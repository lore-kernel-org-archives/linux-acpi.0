From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: suspend / hibernate nomenclature
Date: Sat, 7 Mar 2009 13:41:51 -0300
Message-ID: <20090307164151.GB24668@khazad-dum.debian.net>
References: <1235992429.3858.58.camel@hughsie-work.lan> <20090307154842.GA3947@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090307154842.GA3947@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Richard Hughes <hughsient@gmail.com>, linux-acpi <linux-acpi@vger.kernel.org>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input <linux-input@vger.kernel.org>, Matthias Clasen <mclasen@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On Sat, 07 Mar 2009, Matthew Garrett wrote:
> On Mon, Mar 02, 2009 at 11:13:49AM +0000, Richard Hughes wrote:
> > After reviewing the platform drivers in ACPI, it appears few of them
> > know whether KEY_SLEEP corresponds to suspend or hibernate, and
> > KEY_SUSPEND seems to be used for hibernate. Basically, it's a mess.
> 
> KEY_SUSPEND has always been pretty clearly used for hibernate for, well, 
> forever. I don't think the distinction is a useful one. How many 
> machines are going to have both a sleep and a suspend key?

All machines with a standard crappy PeeCee keyboard with the moon key
have a KEY_SLEEP key, and you can plug a PeeCee USB keyboard in just
about anything nowadays... including on thinkpads, which have a key
that is specific for S4, and one that is specific for S3 in their
internal keyboards.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
