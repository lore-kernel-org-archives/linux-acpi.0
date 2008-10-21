From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Tue, 21 Oct 2008 11:53:49 +0200
Message-ID: <200810211153.52380.trenn@suse.de>
References: <200810192350.57993.trenn@suse.de> <20081020184754.GL18277@khazad-dum.debian.net> <20081020185241.GA14155@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55557 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752024AbYJUJxz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Oct 2008 05:53:55 -0400
In-Reply-To: <20081020185241.GA14155@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

On Monday 20 October 2008 20:52:41 Matthew Garrett wrote:
> On Mon, Oct 20, 2008 at 04:47:54PM -0200, Henrique de Moraes Holschuh wrote:
> > On Mon, 20 Oct 2008, Matthew Garrett wrote:
> > > C state transitions, not S state. Working properly here means not
> > > hanging the moment ACPI processor power management starts.
> >
> > I see, but my point remains.  Does a version of Windows that was tested
> > to do C-state transitions on the R50e and R40e even use the XSDT?
>
> Vista is known to run on the R50e. See
> http://forums.lenovo.com/lnv/board/message?board.id=R_Series_Thinkpads&thre
>ad.id=3467 , for instance.

Linux is also known to run with the R50e:
Hardware Environment: IBM Thinkpad R51e
Problem Description: Since kernel 2.6.20 the acpi modules take an unacceptable
time to load. 

Later:
Ok I can confirm this patch works. Finally after using 2.6.22 for ages i can
update. Thank you all for your effort.

The C-state problem which gets fixed by these is the R40e.

    Thomas
