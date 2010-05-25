From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: acpi_idle: Very idle Core i7 machine never enters C3
Date: Tue, 25 May 2010 13:59:39 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4731E0366B5@shsmsx501.ccr.corp.intel.com>
References: <20100126084740.GA5265@jgarrett.org>
 <87y6jkee1b.fsf@basil.nowhere.org> <20100205160900.GA2736@jgarrett.org>
 <alpine.LFD.2.00.1002051238280.4050@localhost.localdomain>
 <20100426194002.586fbaa5@fido5> <20100427124703.GA16706@jgarrett.org>
 <alpine.LFD.2.00.1004301218280.2489@sony>
 <20100430174447.GA14889@srcf.ucam.org>
 <d7f2dd35a4361e5156079278543769a0@localhost>
 <alpine.LFD.2.00.1005250125590.20648@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43588 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752835Ab0EYGEq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 May 2010 02:04:46 -0400
In-Reply-To: <alpine.LFD.2.00.1005250125590.20648@localhost.localdomain>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Philip Langdale <philipl@overt.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Jeff Garrett <jeff@jgarrett.org>, Andi Kleen <andi@firstfloor.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "venki@google.com" <venki@google.com>



> -----Original Message-----
> From: Len Brown [mailto:lenb@kernel.org]
> Sent: Tuesday, May 25, 2010 1:43 PM
> To: Philip Langdale
> Cc: Matthew Garrett; Jeff Garrett; Andi Kleen; Linux Kernel Mailing
> List; linux-acpi@vger.kernel.org; Yu, Luming; venki@google.com
> Subject: Re: acpi_idle: Very idle Core i7 machine never enters C3
> 
> > >> I am hopeful that the "right thing to do" is to not look at bm-
> status
> > >> and that perhaps there is a bug where we are looking at it
> > >> "by mistake".
> > >
> > > https://patchwork.kernel.org/patch/58962/ - it seems to be a win.
> >
> > Indeed. This patch does solve the C6 problem. I'm not in a position
> to
> > speak about whether there's any undesirable I/O latency, but it
> > passes the basic sanity check.
> >
> > I have filed https://bugzilla.kernel.org/show_bug.cgi?id=15886 with
> > my acpi dump - assuming that's still useful.
> 
> Luming's patch above basically deletes acpi_idle_bm_check() --
> the BM_STS check -- from the C3 path on all Intel SMP boxes.
> This is effectively the same as my test patch
> https://patchwork.kernel.org/patch/77370/
> that made acpi_idle_bm_check() do nothing.
> 
> I'm told by the hardware guys that BM_STS is _not_ always
> a NOP, and so we're not supposed to simply ignore it on C3 --
> though it should be extremely rare that we see it set.

On some platforms like NHM-EX, I was told that it's a NOP,
But I might be given wrong information at that time when I wrote that patch.

IIRC, acpi spec just say it's optional..

Thanks,
Luming
