From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: smartbattery support
Date: Fri, 8 Oct 2004 16:39:47 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16A54BF5D6E14E4D916CE26C9AD30575457124@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Pedro Venda <pjlv-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>On Thu, Oct 07, 2004 at 09:43:20PM +0800, Li, Shaohua wrote:
>> You needed an EC-based SMBus host driver (IIRC, some Acer latops
defined
>> such host in DSDT). ACPI spec has the definition for EC-based SMBus
host
>> interface. Second, a sensor driver for reading smart battery
information
>> is required.
>>
>
>Some times ago, for a toshiba laptop, I began an i2c-acpi-ec driver:
>ftp://ftp.poupinou.org/acpi/i2c-acpi-ec.c
>
>It's a little bit buggy though but this allowed for me to access the
>sensors
>behind the EC.  The main trouble was that there were not actually a
>smbus declared in the ACPI namespace and it was needed to hardcode
where
>is the base adress in the EC space.
>You may try to start with that maybe, and I guess a real
acpi_ec_smb_probe
>function must be written.
Some Acer laptops define the SMBus host as below:
  		Device (SMBC)
                    {
                        Name (_HID, "ACPI0001")
                        Name (_EC, 0x1820)
                        Device (SBS0)
                        {
                            Name (_HID, "ACPI0002")
                            Name (_SBS, 0x02)
                        }
                    }
The base address and the notification number are defined on the _EC
method.
Please check if you system has such definition.

Thanks,
Shaohua


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
