From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: 2.6.16rc5 'found' an extra CPU.
Date: Thu, 2 Mar 2006 07:53:39 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603020737420.28074@montezuma.fsmlabs.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B30063BFB95@hdsmsx401.amr.corp.intel.com>
 <20060302093333.GB18448@pern.dea.icai.upcomillas.es>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751472AbWCBPtQ@vger.kernel.org>
In-Reply-To: <20060302093333.GB18448@pern.dea.icai.upcomillas.es>
Sender: linux-kernel-owner@vger.kernel.org
To: Romano Giannetti <romanol@upcomillas.es>
Cc: "Brown, Len" <len.brown@intel.com>, Dave Jones <davej@redhat.com>, "Raj, Ashok" <ashok.raj@intel.com>, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 2 Mar 2006, Romano Giannetti wrote:

> On Thu, Mar 02, 2006 at 12:49:53AM -0500, Brown, Len wrote:
> > 
> > I'm afraid that even after we get this stuff out of /proc
> > and into sysfs where it belongs, we'll have to leave /proc/acpi around
> > for a while b/c unfortunately people are under the impression
> > that the path names there actually mean something and
> > they can actually count on them -- which they can't.
> 
> Is it possible to obtain the same control/information with sysfs that is
> available from /proc/acpi? For example, I use quite extensively CPU
> throttling on my VAIO ("cool & quiet home-made mode"), and I was unable to
> find the equivalent of /proc/acpi/processor/CPU0/throttling ...

I can't help thinking that that should be going through cpufreq.
