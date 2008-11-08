From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 15/15] Revert "x86: default to reboot via ACPI"
Date: Sat, 8 Nov 2008 23:32:22 +0100
Message-ID: <200811082332.24125.rjw@sisk.pl>
References: <fa.UVpnVba3yRAWG3rGZ0sk20JE9hs@ifi.uio.no> <fa.ckUqcrtVKbxAkjNggIdajBTHr9Q@ifi.uio.no> <49139A43.4000203@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <49139A43.4000203@shaw.ca>
Content-Disposition: inline
Sender: kvm-owner@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>, Matthew Garrett <mjg@redhat.com>
Cc: Zhao Yakui <yakui.zhao@intel.com>, Len Brown <lenb@kernel.org>, Andrey Borzenkov <arvidjaar@mail.ru>, Ingo Molnar <mingo@elte.hu>, Eduardo Habkost <ehabkost@redhat.com>, Avi Kivity <avi@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Friday, 7 of November 2008, Robert Hancock wrote:
> Matthew Garrett wrote:
> > On Fri, Nov 07, 2008 at 09:01:19AM +0800, Zhao Yakui wrote:
> > 
> >> With the help of KVM I find that the windows will be rebooted by writing
> >> RESET_VALUE to RESET_REG I/O port if the RESET_REG_SUP bit is not
> >> zero(It indicates whether ACPI reboot is supported).
> >> IMO maybe the ACPI reboot is the first choice. If it can't, then it will
> >> fall back to other mode.
> > 
> > Hmm. But we're seeing some machines that end up very confused if 
> > rebooted via ACPI. I guess we need to run Vista on them to find out how 
> > they behave. What OSI strings did your KVM setup expose? We know that 
> > Windows changes behaviour under various circumstances depending on which 
> > OS the firmware requests, so it's almost possible that this is another 
> > of those cases.
> 
> Given that Windows behavior, this patch seems suspicious:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=8fd145917fb62368a9b80db59562c20576238f5a
> 
> This patch ignores the RESET_REG_SUP flag and just tries using the reset 
> register anyway if it thinks it's valid. So we may attempt ACPI reset on 
> machines which don't indicate it's supported.
> 
> The patch description mentioned that some machines didn't reboot after 
> S3 suspend without this patch. However, we recently had this patch merged:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=a68823ee5285e65b51ceb96f8b13a5b4f99a6888
> 
> Is it possible that the problem fixed there is the true cause of this 
> reboot after S3 problem?

Generally, it is.

Should it regarded as -stable material, BTW, or is it already in -stable?

Matthew?

Thanks,
Rafael
