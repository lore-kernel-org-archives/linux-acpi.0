From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Unable to resume after standby
Date: Wed, 11 Aug 2004 16:13:03 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040811141303.GD1120@openzaurus.ucw.cz>
References: <4EE0CBA31942E547B99B3D4BFAB34811067A00@mail.esn.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB34811067A00-k4K2Zilj4lNhmhkoCovsdw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Srinivas G." <srinivasg-Jm4/bz9WyEB0+Iju73vM4Za1ZnGqkzdq@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> We are running SuSe 9.1 with kernel version 2.6.5-7.71 on Compaq nx5000
> HP laptop.
> 
>  
> 
> My question is:
> 
> I entered into standby mode using the following command.
> 
>  
> 
> #powersave --standby
> 
>  
> 
> It was working fine. After 2 to 3 seconds it was entered into standby
> mode. But I was unable to find how to resume back. Please tell me how to
> resume back again. When I was entered into standby mode only display was
> gone, CPU led still was glowing.

Unless CPU led went blinking, it did not enter S3. (Thats what I
see, anyway). HP needs to fix their hw (or tell us whats broken
in linux)... I actually talked to their BIOS people, but then
communication died.

fn-F3 works with new-enough bios *if* you access disk during
request. This is bios problem for sure.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
