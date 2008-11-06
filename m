From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 15/15] Revert "x86: default to reboot via ACPI"
Date: Thu, 6 Nov 2008 23:24:19 +0000
Message-ID: <20081106232419.GA8007@srcf.ucam.org>
References: <1225915018-6548-1-git-send-email-ehabkost@redhat.com> <20081106143021.GD13023@elte.hu> <20081106150610.GA1644@elte.hu> <200811061853.08003.arvidjaar@mail.ru> <alpine.LFD.2.00.0811061442590.3106@localhost.localdomain> <20081106215011.GA6391@srcf.ucam.org> <alpine.LFD.2.00.0811061716420.3106@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0811061716420.3106@localhost.localdomain>
Sender: kvm-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, Ingo Molnar <mingo@elte.hu>, Eduardo Habkost <ehabkost@redhat.com>, Avi Kivity <avi@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, kexec@lists.infradead.org, kvm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 06, 2008 at 05:17:25PM -0500, Len Brown wrote:
> > Does Windows default to using the ACPI method now?
> 
> That is my guess, based on the fact that we've seen
> newer machines that don't reboot w/o using the ACPI reset reg.

We've seen machines that won't reboot for a variety of reasons in the 
past. In some cases this has seemed to be due to hardware being in a 
state that the BIOS didn't expect. Hitting the SMI trap behind the ACPI 
register might work around this, but I suspect that in many cases we 
could achieve the same effect by spending more time trying to work out 
whether there's any common themes in the failures.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
