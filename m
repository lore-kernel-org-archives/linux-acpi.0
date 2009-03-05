From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [PATCH] panasonic-laptop: use correct key names for sleep
 states in driver
Date: Thu, 05 Mar 2009 09:09:41 +0000
Message-ID: <1236244181.5432.1.camel@hughsie-work.lan>
References: <1235992429.3858.58.camel@hughsie-work.lan>
	 <20090302112400.GA2356@khazad-dum.debian.net>
	 <1236164049.3936.17.camel@hughsie-work.lan>
	 <1236164306.3936.20.camel@hughsie-work.lan>
	 <20090304235830.GE3974@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20090304235830.GE3974@prithivi.gnumonks.org>
Sender: linux-input-owner@vger.kernel.org
To: Harald Welte <laforge@gnumonks.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Peter Hutterer <peter.hutterer@redhat.com>, mjg <mjg@redhat.com>, linux-input <linux-input@vger.kernel.org>, Matthias Clasen <mclasen@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2009-03-05 at 00:58 +0100, Harald Welte wrote:
> On Wed, Mar 04, 2009 at 10:58:26AM +0000, Richard Hughes wrote:
> > On Wed, 2009-03-04 at 10:54 +0000, Richard Hughes wrote:
> > > On Mon, 2009-03-02 at 08:24 -0300, Henrique de Moraes Holschuh wrote:
> > > > FWIW, I think it is a good idea, and I'd take patches for
> > > > thinkpad-acpi.
> > > 
> > > Patch attached for thinkpad-acpi. KEY_HIBERNATE is already in
> > > linux-next, but has not yet been pushed to master. Please review,
> > > thanks.
> > 
> > Patch also attached for panasonic-laptop. Harald, can you please review
> > this. Thanks.
> 
> Acked-by: Harald Welte <laforge@gnumonks.org>

Dmitry, could you pull this and the thinkpad acpi patch into linux-next
please. Thanks.

Richard.


