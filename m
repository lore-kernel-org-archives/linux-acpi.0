From: "Li, Shaohua" <shaohua.li@intel.com>
Subject: RE: [ACPI] Re: Cause of Suspend2 resume failures on
	Toshiba laptops
Date: Tue, 8 Mar 2005 15:24:21 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD305750155ECE4@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-class: urn:content-classes:message
List-Unsubscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=unsubscribe>
List-Archive: <http://lists.suspend2.net/lurker/list/suspend2-devel.html>
List-Post: <mailto:suspend2-devel@lists.suspend2.net>
List-Help: <mailto:suspend2-devel-request@lists.suspend2.net?subject=help>
List-Subscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=subscribe>
Sender: suspend2-devel-bounces@lists.suspend2.net
Errors-To: suspend2-devel-bounces@lists.suspend2.net
To: "Li, Shaohua" <shaohua.li@intel.com>, Bernard Blackham <bernard@blackham.com.au>, Pavel Machek <pavel@suse.cz>
Cc: acpi-devel@lists.sourceforge.net, suspend2-devel@lists.suspend2.net
List-Id: linux-acpi@vger.kernel.org

>>Yep, been looking into it, and I think I've got it. The GPE in
>>question is fired periodically, about every 5 seconds. It fires when
>>suspending but kacpid is stopped, so the GPE is simply disabled and
>>never serviced. However, the state of it being disabled is recorded
>>in the atomic copy.
>>
>>Upon resume, after restoring the atomic copy, the code at the top of
>>acpi_ev_disable_gpe believes that the GPE is already disabled (as it
>>was when we suspended) even though it's not. Hardware state is out
>>of sync with what the kernel thinks and badness ensues. The culprit
>>difference between 2.6.8 and 2.6.9-rc1 is that 2.6.8 disabled the
>>GPE unconditionally, 2.6.9-rc1 checks against its last known state
>>which is incorrect upon resuming.
>>
>>Removing the check resolves this issue (patch attached). Is this an
>>adequate fix?
>Great analyzing! I guess Both S3, swsusp, and swsusp2 can't suffer from
>this bug. Sure this patch hasn't any side effect. But I wonder if it's
>the right fix. Maybe we should disable all GPEs which have been
disabled
>on very early of resume (that is to restore ACPI hardware's state).
This
>is very useful for suspend-to-disk. If you found a similar bug in S3,
it
>possibly it's BIOS bug (OS didn't enable GPE on resume for S3, but for
>S4, we follow boot time code path, so we possibly enabled some).
Oops, my bad. ACPI has done this, so 'platform' method should survive.
For S5 method, we should disable the disabled GPEs. Leaving the GPE on
will have other side effects. S5 method also has other side effect (Eg.
doesn't invoke _WAK), so I suggest always use 'platform' method.

Shaohua
