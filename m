From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] ACPICA: Fix dispatcher timeout mechanism
Date: Tue, 16 Oct 2018 08:03:30 -0700
Message-ID: <1539702210.129692.12.camel@acm.org>
References: <20181015221848.256323-1-bvanassche@acm.org>
         <CAJZ5v0jDv3ufH+MOXmrygHkBgu4CgT6DZL38xq1ViGiju8VxqQ@mail.gmail.com>
         <1539644495.129692.8.camel@acm.org> <20181016050457.GA6031@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-7"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181016050457.GA6031@kroah.com>
Sender: stable-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, kbuild test robot <fengguang.wu@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Stable <stable@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2018-10-16 at 07:04 +-0200, Greg KH wrote:
+AD4 On Mon, Oct 15, 2018 at 04:01:35PM -0700, Bart Van Assche wrote:
+AD4 +AD4 On Tue, 2018-10-16 at 00:44 +-0200, Rafael J. Wysocki wrote:
+AD4 +AD4 +AD4 On Tue, Oct 16, 2018 at 12:19 AM Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4 wrote:
+AD4 +AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 +AD4 This patch avoids that the following warning is reported during hibernation:
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Well, what exactly is the problem and why is the patch the right way
+AD4 +AD4 +AD4 to address it?
+AD4 +AD4 
+AD4 +AD4 It is not safe to call ktime+AF8-get() after having called timekeeping+AF8-suspend().
+AD4 +AD4 
+AD4 +AD4 +AD4 +AD4  /+ACo
+AD4 +AD4 +AD4 +AD4 diff --git a/drivers/acpi/acpica/dscontrol.c b/drivers/acpi/acpica/dscontrol.c
+AD4 +AD4 +AD4 +AD4 index 0da96268deb5..9dbea4549484 100644
+AD4 +AD4 +AD4 +AD4 --- a/drivers/acpi/acpica/dscontrol.c
+AD4 +AD4 +AD4 +AD4 +-+-+- b/drivers/acpi/acpica/dscontrol.c
+AD4 +AD4 +AD4 +AD4 +AEAAQA -84,8 +-84,8 +AEAAQA acpi+AF8-ds+AF8-exec+AF8-begin+AF8-control+AF8-op(struct acpi+AF8-walk+AF8-state +ACo-walk+AF8-state,
+AD4 +AD4 +AD4 +AD4                 control+AF8-state-+AD4-control.package+AF8-end +AD0
+AD4 +AD4 +AD4 +AD4                     walk+AF8-state-+AD4-parser+AF8-state.pkg+AF8-end+ADs
+AD4 +AD4 +AD4 +AD4                 control+AF8-state-+AD4-control.opcode +AD0 op-+AD4-common.aml+AF8-opcode+ADs
+AD4 +AD4 +AD4 +AD4 -               control+AF8-state-+AD4-control.loop+AF8-timeout +AD0 acpi+AF8-os+AF8-get+AF8-timer() +-
+AD4 +AD4 +AD4 +AD4 -                   (u64)(acpi+AF8-gbl+AF8-max+AF8-loop+AF8-iterations +ACo ACPI+AF8-100NSEC+AF8-PER+AF8-SEC)+ADs
+AD4 +AD4 +AD4 +AD4 +-               control+AF8-state-+AD4-control.loop+AF8-timeout +AD0 jiffies +-
+AD4 +AD4 +AD4 +AD4 +-                   acpi+AF8-gbl+AF8-max+AF8-loop+AF8-iterations +ACo HZ+ADs
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 jiffies is Linux-specific and so it should not be used in the ACPICA code.
+AD4 +AD4 
+AD4 +AD4 Really? There is plenty of other ACPI code that uses the jiffies counter directly.
+AD4 +AD4 Why wouldn't it be allowed to use the jiffies counter in this context since there
+AD4 +AD4 is so much other ACPI code that uses that counter?
+AD4 
+AD4 acpica is different from acpi.  It is the +ACI-core acpi code+ACI that is
+AD4 shared across other operating systems.  That is why jiffies does not
+AD4 work in it :(

Thanks Greg for the feedback. I wasn't aware of the difference between ACPICA and
other ACPI code.

Bart.
