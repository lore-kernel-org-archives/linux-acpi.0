From: Pedro Venda <pjlv-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
Subject: Re: smartbattery support
Date: Mon, 11 Oct 2004 22:25:41 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <416AFA55.2070502@mega.ist.utl.pt>
References: <16A54BF5D6E14E4D916CE26C9AD30575457124@pdsmsx402.ccr.corp.intel.com> <4166EC29.8070006@mega.ist.utl.pt> <20041011094935.GA23992@poupinou.org> <416AD2B3.9050403@mega.ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <416AD2B3.9050403-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
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

Pedro Venda wrote:
>>> Device (SMBC)
>>>                    {
>>>                        Name (_HID, "ACPI0001")
>>>                        Name (_EC, 0x1820)
>>>                        Device (SBS0)
>>>                        {
>>>                            Name (_HID, "ACPI0002")
>>>                            Name (_SBS, 0x02)
>>>                        }
>>>                    }

hi everyone,

i can't get an acpi_handle for the ec host.

i am writing code in bruno ducrot's i2c-ec-smbus driver and i'm trying 
to detect the smbus address from the ACPI's ASL code above.

i'm trying to acpi_get_handle(NULL,"_EC",ec->handle) but it fails 
because of the parent=NULL (i think).

i suspect i need to use the ec driver's device handler in the parent 
paramenter of acpi_get_handle(). is that correct?

or am i doing everything wrong?

[]


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
