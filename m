From: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Subject: Re: eeepc-laptop: bugreport
Date: Sun, 15 Nov 2009 15:54:32 +0000
Message-ID: <4B002438.40508@tuffmail.co.uk>
References: <cone.1258203372.445001.1633.1000@eeekiste>
	<71cd59b00911140641i1502e95bt81d87db848feaf0@mail.gmail.com>
	<cone.1258211472.464906.1633.1000@eeekiste>
	<71cd59b00911150139i5d7377cawda04a17e5e50d05e@mail.gmail.com>
	<cone.1258285991.924736.2588.1000@eeekiste>
	<4AFFF7B8.2070508@tuffmail.co.uk>
	<cone.1258297528.761767.9614.1000@eeekiste>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <cone.1258297528.761767.9614.1000@eeekiste>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=acpi4asus-user>
List-Post: <mailto:acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: andrej.gelenberg-KJIyc1CJxjQ@public.gmane.org
Cc: linux acpi <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Corentin Chary <corentin.chary-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

andrej.gelenberg-KJIyc1CJxjQ@public.gmane.org wrote:
> Alan Jenkins writes:
>
>> At least on the original systems, the eeepc-laptop driver has no way 
>> to control the wireless LED directly.  The wireless LED is set by the 
>> WLDS acpi method (when the wireless is enabled/disabled).
>>
>> The pci hotplug in the eeepc-laptop driver doesn't actually save any 
>> power.  The WLDS acpi method is what actually "unplugs" the PCI 
>> slot.  What eeepc-laptop does is notify the kernel after the fact, so 
>> that the wireless driver doesn't try to talk to hardware that isn't 
>> there.  Without this notification, the wireless driver isn't able to 
>> recover when the wireless is toggled off and back on again.
>>
>> Unfortunately, the BIOS doesn't tell us in advance which device it is 
>> going to unplug.  Hence the hardcoded bus/slot.
>>
>> We may be able to filter the notifications.  The _ADR field on the 
>> P0P* devices tells us which PCI bridge device it corresponds to.  So 
>> we can hopefully avoid toggling the wrong device and disabling the 
>> LAN on 1005ha.
>>
>> But I don't know how to find the _right_ device in a generic way (or 
>> detect that hotplug is not needed and so we should not toggle any 
>> device).
>
> search for wlan on pci-bus? (you can easy walk over all net-devices,
> and then wich have parent-device on pci-subsystem).

Ow.

That won't work if we load before the wireless driver :-(.






------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
