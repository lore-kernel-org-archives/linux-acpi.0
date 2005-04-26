From: "Joe Julian" <joe-Fcm6T8Fmt17HuhbChzYfaQ@public.gmane.org>
Subject: RE: ACPI gobbling all memory on Compaq Armada 7400 w. kernel 2.6.11 on AC disconnect
Date: Tue, 26 Apr 2005 07:40:18 -0700
Message-ID: <000401c54a6d$e1a0f540$6901a8c0@questor>
References: <000c01c5474c$7745b1f0$6901a8c0@questor>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <000c01c5474c$7745b1f0$6901a8c0@questor>
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

Could someone at least give me a hint on what to look for? I don't have time
to study the entire acpi package and learn how everything works but I don't
mind helping.

 
> 
> When I unplug my notebook from AC, everything comes to a 
> grinding halt as something starts eating up all the memory. 
> I've tried shutting down syslog and setting dmesg -n8 but 
> there's nothing to say what's gobbling things up. The kernel 
> (after it fills the swap space) starts killing processes to 
> release more memory. This does not happen if I set acpi=off.
> 
> http://enjoy-the-ride.com/dmesg.txt
> http://enjoy-the-ride.com/acpidmp.txt
> http://enjoy-the-ride.com/lspci.txt
> 
> dmidecode:
> # dmidecode 2.6
> # No SMBIOS nor DMI entry point found, sorry.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
