#include <bits/stdc++.h>
using namespace std;

struct Process {
    int pid;
    int at;
    int bt;
    int ct;
    int wt;
    int tat;

    Process(int process_id, int arrival_time, int burst_time) {
        pid = process_id;
        at = arrival_time;
        bt = burst_time;
    }
};

class RoundRobin {
    int time_quantum;
    queue<pair<Process*, int>> process_queue;
    vector<Process> processes;
    vector<Process> finished;

    static bool comp(const Process& a, const Process& b) {
        if (a.at < b.at) {
            return true;
        } else if (a.at == b.at && a.pid < b.pid) {
            return true;
        }
        return false;
    }

public:
    RoundRobin(vector<Process> pro, int tq) {
        processes = pro;
        time_quantum = tq;
        sort(processes.begin(), processes.end(), comp);
    }

    void execute() {
        int curr_time = 0;
        int n = processes.size();
        int i = 0;

        while (i < n || !process_queue.empty()) {
            while (i < n && curr_time >= processes[i].at) {
                process_queue.push({&processes[i], processes[i].bt});
                i++;
            }

            if (process_queue.empty()) {
                curr_time = processes[i].at;
                continue;
            }

            Process* p = process_queue.front().first;
            int curr_bt = process_queue.front().second;
            process_queue.pop();

            if (curr_bt <= time_quantum) {
                p->ct = curr_time + curr_bt;
                p->wt = p->ct - p->at - p->bt;
                p->tat = p->ct - p->at;
                finished.push_back(*p);
                curr_time += curr_bt;
            } else {
                process_queue.push({p, curr_bt - time_quantum});
                curr_time += time_quantum;
            }
        }
    }

    void showProcessData() {
        int n = finished.size();
        cout << "PID\tAT\tBT\tCT\tWT\tTAT\n";
        for (int i = 0; i < n; i++) {
            Process p = finished[i];
            cout << p.pid << "\t"
                << p.at << "\t"
                << p.bt << "\t"
                << p.ct << "\t"
                << p.wt << "\t"
                << p.tat << "\n";
        }
    }
};

vector<Process> dummy_processes() {
    Process p1 {1, 0, 17};
    Process p2 {2, 2, 13};
    Process p3 {3, 12, 6};
    Process p4 {4, 8, 14};
    return {p1, p2, p3, p4};
}

int main() {
    vector<Process> processes = dummy_processes();
    RoundRobin* rb = new RoundRobin(processes, 2);
    rb->execute();
    rb->showProcessData();
}
