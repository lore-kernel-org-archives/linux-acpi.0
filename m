From: Chris Jensen <c-acpi-s2nexXcBJu3PC4JL755TaA@public.gmane.org>
Subject: ACPI Thermal Shutdown on Boot
Date: Tue, 10 Feb 2004 17:48:21 +1100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200402101748.21855.c-acpi@drspirograph.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
I've got a couple of problems with the ACPI thermal support in 2.6.2

I'm trying to install kernel 2.6.2. However, as soon  as the kernel starts 
init, I get a message along the lines of "Critical Temperature reached - 57C, 
shutting down" and init switches to runlevel 0.
(I got the same behaviour trying to install 2.6.1, but without the message 
telling me why)

The system had been powered on for 2 days straight, so I think it's safe to 
keep it running at that temp, I'd like to keep the thermal protection 
compiled into the kernel to protect against a really high temperature should 
a fan fail etc, so I'd like to adjust the critical temperature so it doesn't 
shutdown.

How can I adjust the critical temperature? I realise that there's a file 
in /proc that can be adjusted, but as init is shutting down immediately, 
there doesn't seem to be an oportunity to do this.


The other issue is that although the kernel said the temperature was 57C, if I 
reboot and jump into the BIOS settings, it says its 67C, so there seems to be 
some discrepency there.

I'm using a Gigabyte motherboard with a VIA KT133 chipset (VT82C686).
It has a shutdown threshold in the BIOS settings, which I've tried increasing, 
but it didn't help.

-- 
Chris Jensen
chris-s2nexXcBJu3PC4JL755TaA@public.gmane.org

Public Key: http://drspirograph.com/public_key/

Wait: Did you know that there's a direct correlation between the decline of
Spirograph and the rise in gang activity?  Think about it.
- Dr Spirograph (The Simpsons)



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
