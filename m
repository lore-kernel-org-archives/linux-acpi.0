From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI high interrupt rate with vanilla 2.4.22
Date: Thu, 28 Aug 2003 10:26:22 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030828082622.GA382@poupinou.org>
References: <20030826124405.2b6635f2.gigerstyle@gmx.ch> <3F4C443E.80207@sbox.tugraz.at> <3F4C59E3.1050603@sbox.tugraz.at> <20030827094320.5048717b.gigerstyle@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030827094320.5048717b.gigerstyle-OI3hZJvNYWs@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Marc Giger <gigerstyle-OI3hZJvNYWs@public.gmane.org>
Cc: Gerfried Maier <moali-ArvQUR6U0fYD0fefG/KofA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Aug 27, 2003 at 09:43:20AM +0200, Marc Giger wrote:
> On Wed, 27 Aug 2003 09:12:35 +0200
> Gerfried Maier <moali-ArvQUR6U0fYD0fefG/KofA@public.gmane.org> wrote:
> 
> > Gerfried Maier wrote:
> > 
> > > Marc Giger wrote:
> > >
> > >> [...]
> > >> Another thing is /proc/acpi/processor/
> > >> There are 2 CPU entries...?!?
> > >>
> > > Do you have a P4 with the "mulithreading" feature? This appears
> > > under Linux as a second CPU.
> > 
> >                                                ^^^^^^^^^^
> > Sorry, I meant hyperthreading, of course.  Please excuse the
> > confusion...
> 
> No problem. And no it's not a P4 with HT, but the Board (Asus
> P4T533-C) is HT capable. AFAIK every P4 processor has the ht flag...
> 

Your board should be SMP capable.  ACPI describe only what
firmware know about, and some bios will report 2 processors regardless
of the actual number.  Just that the second is not online.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
