From: wwp <subscript-GANU6spQydw@public.gmane.org>
Subject: Re: Need help interpreting my DSDT
Date: Tue, 3 May 2005 10:12:22 +0200
Message-ID: <20050503101222.071a4234@localhost.localdomain>
References: <1083513325.23963.8.camel@scotchmobil>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1083513325.23963.8.camel@scotchmobil>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello Janosch,


On Sun, 02 May 2004 17:55:25 +0200 Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org> wrote:

> Hi, 
> sorry, if you get this mail two times... 

Are you posting from an outer planet or from the past? Please check your
system date, it shows 2004 (IIRC we are in 2005). This might help your emails
to get a reply (otherwise they might not be seen at all).


Regards,

> Okay, I figured out, that my notbeook supports up to 4 C-states. The
> problem is, that if I boot under Linux the ACPI returns only 1 C-state. 
> I tracked this to following asl code :
>  If (\_SB.INV7)
>                 {
>                     Return (NOC3)
>                 }
> 
>                 If (\_SB.BATO)
>                 {
>                     Return (BCST)
>                 }
>                 Else
>                 {
>                     Return (ACST)
>                 }
> In my case NOC3 is returned. This means that \_SB.INV7 is set. My
> question now is what exactly is \_SB.INV7 ? 
> I found one method manupilating \_SB.INV7 :
>   Scope (\_SB)
>     {
>         OperationRegion (GPIO, SystemIO, IO2B, 0x40)
>         Field (GPIO, ByteAcc, NoLock, Preserve)
>         {
>             Offset (0x0C), 
>                 ,   7, 
>             G07S,   1, 
>                 ,   9, 
>             G17S,   1, 
>                 ,   9, 
>             G27S,   1, 
>             G28S,   1, 
>             Offset (0x2C), 
>                 ,   3, 
>             BT1S,   1, 
>                 ,   3, 
>             INV7,   1, 
>                 ,   3, 
>             LIDL,   1, 
>             Offset (0x38), 
>             BKLT,   1, 
>             BAYI,   2
>         }
>     }
> 
>     Scope (\_GPE)
>     {
>         Method (_L17, 0, NotSerialized)
>         {
>             If (\_SB.INV7)
>             {
>                 Store (0x00, \_SB.INV7)
>             }
>             Else
>             {
>                 Store (0x01, \_SB.INV7)
>             }
> 
>             Notify (\_PR.CPU1, 0x81)
>         }
> So has anyone an idea what INV7 could be ? 
> THX
>    Janosch
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: NEC IT Guy Games.
> Get your fingers limbered up and give it your best shot. 4 great events, 4
> opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
> win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 


-- 
wwp



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
