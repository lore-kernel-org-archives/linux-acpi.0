From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Testing: NVidia closed driver fails.
Date: Fri, 20 Sep 2002 11:54:36 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020920095436.GE311@poup.poupinou.org>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE93@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DE93-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "'P. Christeas'" <p_christ-U04EIuiosng@public.gmane.org>, Jochen Reinwand <jbr.1-hi6Y0CQ0nG0@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Sep 19, 2002 at 03:26:52PM -0700, Grover, Andrew wrote:
> > From: P. Christeas [mailto:p_christ-U04EIuiosng@public.gmane.org] 
> > > With ACPI enabled X gets slow. I mean REALLY SLOW! It needs up to 20
> > > seconds to start and then consumes as much CPU time as 
> > possible. It's an
> > > adventure to try to hit something with the mouse pointer.
> > > Everything is funktioning perfectly without ACPI.
> > > Perhaps an interrupt problem. ACPI shares an interrupt with 
> > a bttv card.
> > > The GeForce has it's own interrupt.
> > Huh! You just mentioned a magic word: bttv. I do have a bt878 
> > card, I have to 
> > look if that is the problem after all.
> > 
> > To A. Grover: if the trouble lies in the bttv driver, the 
> > kernel will be 
> > considered broken until both drivers co-exist..
> 
> When you cat /proc/interrupts, is there a huge and ever-increasing number of
> interrupts listed for the shared irq?
> 
> (Wait, I thought video devices weren't interrupt driven? Or is that only
> video out, not video-in, like bt878?)

Some of them are interrupt driven, like some Nvidia cards, certainly when
you configure the so-called Nvidia TwinView(TM) feature of such card.

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
