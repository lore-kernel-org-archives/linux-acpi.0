From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Battery status reading problems
Date: Mon, 22 Sep 2003 14:52:51 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030922125251.GI11391@poupinou.org>
References: <m2vfrpthxt.fsf@tnuctip.rychter.com> <Pine.LNX.4.58.0309192257480.1613@phoenix.kerstin.at> <3F6EAADC.4020509@basmevissen.nl> <Pine.LNX.4.53.0309220954120.9385@dynast.gaugusch.at> <1064230622.8592.14.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1064230622.8592.14.camel-Z+iYsftfazAXoXS6vNje7nviChZXdy279dF7HbQ/qKg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Sep 22, 2003 at 12:37:03PM +0100, Alan Cox wrote:
> On Llu, 2003-09-22 at 08:56, Markus Gaugusch wrote:
> > I don't think, that the code is slow, but during execution of the battery
> > query (which takes some time, because it is on a slow bus) the kernel
> > seems to hang - probably a kernel thread would cure this problem, but I'm
> > no expert in this area.
> 
> Several vendors implement the actual battery reading logic as an SMI
> trap and disable interrupts during their slow chat with the battery.
> There isnt much anyone can do about that bit alas (except read it a lot
> less often)
> 

I would expect more batery read are done via the Embeded Controller, and
pass by his firmware in order to know what to do exactly, that is pass
the query to the i2c bus of that embedded controller.  Therefore, slow
read may be indication of:
- i2c bus is more or less busy (unfortunately, that one most likely handle
  other sensors like thermal, etc.).  Contention happens and since thermal
  zone is (ab)used, that will happen likely I think, looking the OP mail.
- firmware bug for that embedded controller.

I'm ok though for the fact that some OEM will do read battery via obscur
SMI methods, Dell being the one that abuse that kind of method.

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
