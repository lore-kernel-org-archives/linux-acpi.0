From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH 15/15] Revert "x86: default to reboot via ACPI"
Date: Fri, 07 Nov 2008 09:01:19 +0800
Message-ID: <1226019679.3989.107.camel@yakui_zhao.sh.intel.com>
References: <1225915018-6548-1-git-send-email-ehabkost@redhat.com>
	 <20081106143021.GD13023@elte.hu> <20081106150610.GA1644@elte.hu>
	 <200811061853.08003.arvidjaar@mail.ru>
	 <alpine.LFD.2.00.0811061442590.3106@localhost.localdomain>
	 <20081106215011.GA6391@srcf.ucam.org>
	 <alpine.LFD.2.00.0811061716420.3106@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46360 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752933AbYKGAyJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Nov 2008 19:54:09 -0500
In-Reply-To: <alpine.LFD.2.00.0811061716420.3106@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Matthew Garrett <mjg@redhat.com>, Andrey Borzenkov <arvidjaar@mail.ru>, Ingo Molnar <mingo@elte.hu>, Eduardo Habkost <ehabkost@redhat.com>, Avi Kivity <avi@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 2008-11-07 at 06:17 +0800, Len Brown wrote:
> 
> > > My expectation is that with the ACPI default, our problem
> > > is working around a finite list of old machines that don't work;
> > > while with the default KBD, our problem is working around
> > > a potentially unbounded list of yet to be shipped machines
> > > who may only be tested and work using the ACPI method.
> > 
> > Does Windows default to using the ACPI method now?
> 
> That is my guess, based on the fact that we've seen
> newer machines that don't reboot w/o using the ACPI reset reg.
With the help of KVM I find that the windows will be rebooted by writing
RESET_VALUE to RESET_REG I/O port if the RESET_REG_SUP bit is not
zero(It indicates whether ACPI reboot is supported).
IMO maybe the ACPI reboot is the first choice. If it can't, then it will
fall back to other mode.

Thanks.
> 
> -Len
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

