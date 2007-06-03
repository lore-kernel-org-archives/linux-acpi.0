From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: Add INPUT support to toshiba_acpi
Date: Sun, 3 Jun 2007 00:48:39 -0400
Message-ID: <200706030048.40393.dtor@insightbb.com>
References: <1180614979.2693.26.camel@localhost.localdomain> <1180788652.2355.27.camel@localhost.localdomain> <20070602142333.GA3452@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763644AbXFCEsy@vger.kernel.org>
In-Reply-To: <20070602142333.GA3452@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Richard Hughes <hughsient@gmail.com>, Bastien Nocera <hadess@hadess.net>, John Belmonte <john@neggie.net>, linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Saturday 02 June 2007 10:23, Matthew Garrett wrote:
> On Sat, Jun 02, 2007 at 01:50:52PM +0100, Richard Hughes wrote:
> > > KEY_SCREENLOCK? KEY_SCREENSAVER?
> > 
> > Either of these keys would be good to add.
> 
> We've been interpreting "KEY_COFFEE" as screenlock (as in "I've gone for 
> a coffee break, lock the screen").
> 

It looks like KEY_COFFE comes from 0x0c/0x19e - AL Terminal Lock/Screensaver
so your interpretation is indeed correct. I guess I better add an alias to
input.h

-- 
Dmitry
