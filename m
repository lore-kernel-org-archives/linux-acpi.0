From: Pedro Venda <pjlv-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
Subject: Re: smartbattery support
Date: Fri, 08 Oct 2004 20:29:16 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4166EA8C.40809@mega.ist.utl.pt>
References: <16A54BF5D6E14E4D916CE26C9AD30575456AB2@pdsmsx402.ccr.corp.intel.com> <20041008082923.GD6785@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041008082923.GD6785-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Bruno Ducrot wrote:
> On Thu, Oct 07, 2004 at 09:43:20PM +0800, Li, Shaohua wrote:
> 
>>You needed an EC-based SMBus host driver (IIRC, some Acer latops defined
>>such host in DSDT). ACPI spec has the definition for EC-based SMBus host
>>interface. Second, a sensor driver for reading smart battery information
>>is required.
>>
> 
> 
> Some times ago, for a toshiba laptop, I began an i2c-acpi-ec driver:
> ftp://ftp.poupinou.org/acpi/i2c-acpi-ec.c
> 
> It's a little bit buggy though but this allowed for me to access the sensors
> behind the EC.  The main trouble was that there were not actually a
> smbus declared in the ACPI namespace and it was needed to hardcode where
> is the base adress in the EC space.
> You may try to start with that maybe, and I guess a real acpi_ec_smb_probe
> function must be written.
> 

i'll give it a read. thanks.


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
