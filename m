From: Jurgen Kramer <gtm.kramer-c1aixF9oqgPk1uMJSBkQmQ@public.gmane.org>
Subject: Re: Switching LCD off on a laptop (or change to CRT)
Date: 23 Sep 2002 18:36:07 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1032798967.1161.9.camel@paragon.slim>
References: <871y7kkd7s.fsf@lexx.delysid.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <871y7kkd7s.fsf-lBiwR96x4xkvSoioSV8wqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Mario Lang <mlang-0OxMAPPu35xAfugRpC6u6w@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

I have the Japanese version of this laptop (Victor MP-XP7210) do the
Fn+F4, Fn+F5, Fn+F6 and Fn+F7 work for you? I asked a question about
this on the maillist but there no reply.

BTW Fn+F10 works for me with kernel 2.4.19 + ACPI 20020918. The LCD does
go off. I do not have the VGA connector cable so I cannot see if it
switches to VGA output.

Cheers,

Jurgen

On Mon, 2002-09-23 at 16:11, Mario Lang wrote:
    hello.
    
    I recently got a JVC MP-XP7210DE.  First of all, congrats,
    ACPI worked out of the box with 2.4.20pre7.  I have correct
    ac_adaptor info, correct battery info (even for both
    slots), and the power button works too under acpid.
    
    One remaining glitch I have is getting the internal
    display to switch off.  Under XP, this works fine
    with Fn-F10.  If I do this under Linux, I get a message
    telling me that this button is not implemented (on the console).
    
    Well, that indicates that this LCD display off thing
    must be done by the operating system.
    
    Well, I'm blind[1], and I realllllly don't need that display,
    and switching it off would save alot of power.  Any hint
    on what I could try to achieve this would be very helpful.
    
    Does any of the acpi patches already support that?  I think
    it should be a acpi standard, as there is a screen
    saver for Windows NT which does exactly that via ACPI (turn
    the display off).
    
    [1] Yeah, don't be supprised, that works really nicely.
    I use speech and braille output (mostly speech while I'm mobile though),
    and the display is really just a waste of energy most of the time.
    
    P.S.: Sorry to bother the -devel list with that, but it
    is very very difficult to get competent answers for
    ACPI questions.  All HOWTOs seem to still refer
    to APM, and well, this notebook doesnt seem to have apm.
    
    -- 
    CYa,
      Mario
    
    
    
    -------------------------------------------------------
    This sf.net email is sponsored by:ThinkGeek
    Welcome to geek heaven.
    http://thinkgeek.com/sf
    _______________________________________________
    Acpi-devel mailing list
    Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel
    
    



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
