From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: AE_BAD_HEX_CONSTANT
Date: Tue, 09 Nov 2004 11:49:44 -0800
Message-ID: <41911F58.6020300@root.org>
References: <20041109193331.930.qmail@web41101.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041109193331.930.qmail-0Htg24VVpk2A/QwVtaZbd3CJp6faPEW9@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Paulo da Silva <pvmagacho78-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Paulo da Silva wrote:
> Hello,
> 
>  I am having a few problems with the battery
> information with my Acer Aspire 1613Lmi.
>  I get the following error :
> kernel:  psparse-1133: *** Error: Method execution
> failed [\_SB_.PCI0.LPC0.EC__.GBIF] (Node dfe6e480),
> AE_BAD_HEX_CONSTANT
> kernel:  psparse-1133: *** Error: Method execution
> failed [\_SB_.PCI0.LPC0.EC__.BAT0._BIF] (Node
> dfe6de00), AE_BAD_HEX_CONSTANT
> 
> I tracked down to the lines in the ASL code. I've
> attached part of the DSDT containing this lines. The
> part that gives the problem is pointed out. 
> 
> The whole DSDT can be seen at :
> http://cern.ch/paulo/dsdt.dsl.orig
> 
> Thanks in advance for any help.

The problem is here:
                   Store ("Bat 8Cell", Index (Arg1, 0x09))
                   Store ("236", Index (Arg1, 0x0A))
                   Store ("Lion", Index (Arg1, 0x0B))
                   Store ("Acer", Index (Arg1, 0x0C))

If you look at the value being dereferenced as the destination arg, it's 
a string.  So this should really store a string to a string.  For some 
reason, ACPI-CA is attempting to convert the string to an Integer before 
storing it.

                         Name (BT0I, Package (0x0D)
                         {
                             0x01,
                             0x19C8,
                             0x19C8,
                             0x01,
                             0x39D0,
                             0x014A,
                             0xDC,
                             0x012C,
                             0x0294,
                             "ANA",
                             "110",
                             "Lion",
                             0x00
                         })

Looking more carefully, it looks like commenting out just the last line 
("Acer") would suffice.  Index 0xC is actually an integer (0x00) so this 
is what triggers the Integer conversion.  I'm not sure how the 
conversion rules should be modified to take this into account.

-- 
Nate


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
