From: Christian Axelsson <smiler-pw/8oln/LLv0Dx+PQ6IoOQ@public.gmane.org>
Subject: Re: smartbattery support
Date: Tue, 05 Oct 2004 23:54:17 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <41631809.7020204@lanil.mine.nu>
References: <41630B6D.2000107@mega.ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41630B6D.2000107-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pedro Venda <pjlv-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Pedro Venda wrote:
> i read some things also, but i disagree with christian. i think that 
> smbus patch is not the way to go. don't get me wrong! i'm also just 
> scratching the surface. for what i read, those patches put smbus bios 
> support into the kernel.

yep

> 1. is this a "sensor" i2c driver? i mean, should we find help with the 
> lmsensors team? there are some debugging tools for i2c developed by the 
> lm-sensors people (i guess). this document 
> (http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/chips/SUMMARY) 
> refers some smartbattery support, but i don't think it solves our problem.

I cant get the detect-thingies to see any i2c-bus and Im not aware of 
any sensorchip in my laptop (but I would be happy to be proven wrong).

> 2. what exactly should the i2c driver do? should it just know the 
> smartbattery address and ask generic questions made by userland 
> programs? or should it do all the work and retrive charge rates and 
> capacity information and such?

I think it should publish as much generic info (info thats avaible on 
all smartbatteries) as possible into sysfs.

-- 
Regards,
Christian


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
