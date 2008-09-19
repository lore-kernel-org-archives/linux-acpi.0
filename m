From: Chris Rankin <rankincj@yahoo.com>
Subject: Thinkpad T60p does not recover from Suspend when docked.
Date: Fri, 19 Sep 2008 07:30:42 -0700 (PDT)
Message-ID: <631160.40261.qm@web52908.mail.re2.yahoo.com>
Reply-To: rankincj@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751872AbYISOay@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I have a Thinkpad T60p with an "advanced dock" that contains an extra SATA drive, and I have noticed that when the extra drive is in the docking station then the laptop no longer recovers from Suspend. Remove the drive from the docking station and the laptop suspends and resumes OK again.

My user-space environment is Fedora 9, which automatically mounts the docking station's drive under /media when I login. However, it doesn't make any difference if I unmount this drive before suspending - the laptop fails to recover regardless.

I am running a 2.6.25.17-SMP kernel (for graphics card reasons), and can provide ACPI table dumps if required. Can anyone suggest anything to try, please?

Thanks,
Chris



      
