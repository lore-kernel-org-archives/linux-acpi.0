From: Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [Regression] PCI / PM: Simplify device wakeup settings code
Date: Fri, 13 Apr 2018 13:56:12 -0400
Message-ID: <56a8953c-d833-837c-57d5-fe758d4db02a@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: lenb@kernel.org, bhelgaas@google.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 1745646@bugs.launchpad.net
List-Id: linux-acpi@vger.kernel.org

Hi Rafael,

A kernel bug report was opened against Ubuntu [0].  After a kernel
bisect, it was found that reverting the following two commits resolved
this bug:

0ce3fcaff929 ("PCI / PM: Restore PME Enable after config space restoration")
0847684cfc5f("PCI / PM: Simplify device wakeup settings code")
 
This is a regression introduced in v4.13-rc1 and still exists in
mainline.  The bug causes the battery to drain when the system is
powered down and unplugged, which does not happed prior to these two
commits.  The bisect actually pointed to commit de3ef1e, but reverting
these two commits fixes the issue.
    
I was hoping to get your feedback, since you are the patch author.  Do
you think gathering any additional data will help diagnose this issue,
or would it be best to submit a revert request?
   
   
Thanks,

Joe

[0] http://pad.lv/1745646
