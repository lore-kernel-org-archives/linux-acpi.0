From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Re: [Acpi4asus-user] ASUS M2400N / M3700N / S1300N temperature
Date: Tue, 19 Aug 2003 16:13:49 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030819141349.GM18032@poupinou.org>
References: <20030814025858.GA16098@hell.org.pl> <1060944604.1760.1.camel@M2400N> <20030815142258.GA2643@hell.org.pl> <1060959167.2144.19.camel@Home> <20030815205541.GB25102@hell.org.pl> <1061221384.1996.6.camel@M2400N> <20030819140334.GB4265@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030819140334.GB4265-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Mads Paulin <paulin-/w0Os/Ss2Sh/SzgSGea1oA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Aug 19, 2003 at 04:03:34PM +0200, Karol Kozimor wrote:
> Thus wrote Mads Paulin:
> > I have an ASUS M2400N and is trying to get the fan control right. Karol
> > solved the temperature reading problem, but due to wron thermal trip
> 
> Did I really? From what you said before, I understood it didn't work.
> Let's look at the code:
> #v+
>     Method (_TMP, 0, NotSerialized)
>     {
>         Store (0x05, Local1)
>         While (Local1)
>         {
>             Store (RTMP (), Local0)
>             If (LGreater (Local0, TCRT))
>             {
>                 Decrement (Local1)
>             }
>             Else
>             {
>                 Store (0x00, Local1)
>             }
>         }
> 
>         Return (KELV (Local0))
>     }
> [...]
>     Method (RTMP, 0, NotSerialized)
>     {
>         Store (RBYT (TSAD, 0x01), Local0)
>         If (Not (Local0))
>         {
>             Store (Local0, LTMP)
>         }
> 
>         Return (LTMP)
>     }
> #v-
> 
> This is the original one. If the (RBYT (TSAD, 0x01) is supposed to return
> temperature, it should rather not be zero. Thus, the condition in RTMP
> always fails. Since LTMP is initialized with 0x3c (60d), the _TMP method
> always returns (KELV (60)), and also, since RTMP is also used internally,
> the fan keeps spinning at the same speed. 

Problem is: I still don't have time to debug that.  A good approach
imho for debugging all that stuff is to simulate the RTMP by
translating this method in C.  It's straightforward, but sorry, I don't
have time for.  Then you will see if it is a bug in the aml interpreter,
or a bug in the AML.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by Dice.com.
Did you know that Dice has over 25,000 tech jobs available today? From
careers in IT to Engineering to Tech Sales, Dice has tech jobs from the
best hiring companies. http://www.dice.com/index.epl?rel_code=104
