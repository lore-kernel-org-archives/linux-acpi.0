From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Problems with battery info
Date: Fri, 30 Aug 2002 19:41:53 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020830174153.GA14014@poup.poupinou.org>
References: <E17jSOa-0000F3-00@incognito>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E17jSOa-0000F3-00-MNhIyYEChGthl2p70BpVqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Luis Miguel Pires Neves <lneves-3+EeCmRbAIo+BYJ/izffpQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Aug 26, 2002 at 11:31:39PM +0100, Luis Miguel Pires Neves wrote:
> Hi everybody,
> 
> It is not the first time I post this subject but until now I got no answer, 
> perhaps because I included it in the middle of others.
> 
> I'm still using the 20020403 acpi patch on top of 2.4.18 because with recent 
> versions I don't get a correct battery info (it says that the battery is NiMH 
> of 4500 mWh instead of the 3200 mWh my LiIon battery really has, causing a 
> wrong battery level information trough WMACPI). 
> 
> This behaviour used to happen with the acpi code before february, but then I 
> used to change a constant value in ectransx.c (a timeout if I remember) from 
> 100 to 500 (us ???) to solve it. With the acpi code between February and 
> April this wasn't necessary anymore.
> 
> I must admit I've not tried all versions from April till now, but I tried 
> several, 20020716 as the last one, and the problem reappeared, and I don't 
> know what I can do to overcome it.
> 
> In dmesg I found the following messages:
> 
> [ACPI Debug] String: ========= BAT1 UPBI =========
> dsmthdat-0433 [22] Ds_method_data_get_val: Uninitialized Local[3] at node 
> c7b6b54c
> dsmthdat-0433 [22] Ds_method_data_get_val: Uninitialized Local[3] at node 
> c7b6b54c
> 


The method implied is:


            Method(UPBI,0,NotSerialized)
            {
                Store("========= BAT1 UPBI =========",Debug)
                Store(Zero,Local0)
                Store(0x0C,Local1)
                Store(Buffer(0x0D){0x00,0x18,0x10,0x00,0x19,0x00,0x00,0x00,
                        0x00,0x00,0x1C,0x22,0x00},Local2)
                While(LGreater(Local1,0x0A))
                {
                    If(LNot(And(UBIF /* \_SB.BAT1.UBIF */,VTOB /* \_SB.VTOB */(Local1))))
                    {
                        GBFE /* \_SB.GBFE */(Local2,Local1,RefOf(Local3))
                        If(Local3)
                        {
                            If(LNot(\_SB.PCI0.PIB.EC0.SMRD(0x0B,0x16,Local3,RefOf(Local4))))
                            {
                                GBFE /* \_SB.GBFE */(Local4,0x20,RefOf(Local5))
                                PBFE /* \_SB.PBFE */(Local4,Local5,0x00)
                                Store(Local4,Index(PBIF /* \_SB.BAT1.PBIF */,Local1))
                                Or(UBIF /* \_SB.BAT1.UBIF */,VTOB /* \_SB.VTOB */(Local1),UBIF /* \_SB.BAT1
.UBIF */)
                                Store(Ones,Local0)
                            }
                        }
                    }
                    Decrement(Local1)
                }

GBFE((Local2,Local1,RefOf(Local3))
is called, but Local3 is not initialised.  Perhaps if you do something like:

Store(Zero, Local3)

before calling 'GBFE((Local2,Local1,RefOf(Local3))'
it would work.  But I am not sure, anyway, if it is the proper way to go..

Note also that there is also a GBFE(..., ..., RefOf(Local4)) and a
GBFE(..., ..., RefOf(Local5))
which can have the same trouble.


So I think that you should try to make something like:

            Method(UPBI,0,NotSerialized)
            {
                Store("========= BAT1 UPBI =========",Debug)
                Store(Zero,Local0)
                Store(0x0C,Local1)
                Store(Zero,Local3)
                Store(Zero,Local4)
                Store(Zero,Local5)
		...
		...

and you will see if it work.

I suspect it is actually a bug in the current ACPI interpreter, but I must
admit that I am not sure at 100%, though.

Cheers

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
