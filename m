From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.25-git: "x86: fix ioremap RAM check" causes - ACPI
	Error... Could not map memory
Date: Mon, 4 Feb 2008 13:27:24 +0100
Message-ID: <20080204122724.GA31186@elte.hu>
References: <200802040228.39880.lenb@kernel.org> <200802041320.47495.rjw@sisk.pl> <20080204122505.GA30564@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754020AbYBDM15@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080204122505.GA30564@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> 
> > On Monday, 4 of February 2008, Len Brown wrote:
> > > My HP nx6325 started printing the ACPI Error's below starting at 
> > > the commit below.
> > 
> > Mine too.
> 
> does latest x86.git#mm fix it?

access coordinates:

  http://people.redhat.com/mingo/x86.git/README

	Ingo
