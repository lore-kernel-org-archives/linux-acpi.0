From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH v2] acpi: Fix regression where _PPC is not read at boot even when ignore_ppc=0
Date: Wed, 29 Apr 2009 15:19:28 +0200
Message-ID: <200904291519.29683.trenn@suse.de>
References: <20090415225348.GW8311@plum> <200904201113.31371.trenn@suse.de> <20090420104529.GB6670@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761381AbZD2NUN@vger.kernel.org>
In-Reply-To: <20090420104529.GB6670@elte.hu>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "Darrick J. Wong" <djwong@us.ibm.com>, linux-kernel <linux-kernel@vger.kernel.org>, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.orgMatthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-acpi@vger.kernel.org

On Monday 20 April 2009 12:45:29 Ingo Molnar wrote:
> 
> * Thomas Renninger <trenn@suse.de> wrote:
> 
> > On Monday 20 April 2009 07:13:51 Len Brown wrote:
> > > FYI,
> > > Thanks to Ebay, I now have a T60:-)
> > Hmm, Lenovo sold a lot different machines as T60.
> > I found an acpidump of a T60 here without any _PPC function
> > at all.
> > 
> > > and so i put the DSDT here:
> > > http://bugzilla.kernel.org/show_bug.cgi?id=13139
> > > 
> > > I'll poke at this in more detail soon...
> > Ingo, can you place yours somewhere too, please.
> > This one should be taken into account for _PPC code changes
> > as it seem to implement some corner case.
> 
> Sure, find it attached below.
> 
> 	Ingo
> 
> DSDT @ 0x7f6e65e7
>   0000: 44 53 44 54 65 c7 00 00 01 49 4c 45 4e 4f 56 4f  
...
Ingo, did you do a BIOS update in between?
The DSDT and SSDTs you added do not contain a _PPC function.
These ACPI tables definitely do not suffer from an initial _PPC
evaluation.

    Thomas
