From: Heiko Ettelbrueck <hbruckynews-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Problems installing ACPI
Date: Tue, 21 Jan 2003 13:03:59 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E2D372F.5040500@gmx.net>
References: <1043083690.1702.15.camel@localhost.localdomain>	<3E2C43D3.3020307@gmx.net>  <3E2C70FB.1090905@gmx.net> <1043147191.1205.8.camel@gregers.imsb.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1043147191.1205.8.camel-bkBLLvNVh9RMk0OslVgrwH9LOBIZ5rWg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Christian Brix Folsted Andersen <folsted-TJNDrJVYK8B/SzgSGea1oA@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Christian Brix Folsted Andersen wrote:
> However i am having a bit of a problem applying your patch. The file
> drivers/acpi/osl.c does not exist instead there is a file called os.c.
> I looked at the file and tried to patch it manualy, but can not find the
> position of the last part of the patch.
> 
> The first part was added at line 85 of os.c
> 
> static int acpi_irq_irq = 0;
> static OSD_HANDLER acpi_irq_handler = NULL;
> static void *acpi_irq_context = NULL;
> 
> extern unsigned char AmlCode[];
> 
> In which function is the last part supposed to go?
> Which kernel did you use?

I use a vanilla kernel 2.4.20 with the ACPI patch 20021205. Did you use 
another ACPI patch? Perhaps this part has changed...

The last part of the patch is for the function acpi_os_table_override:

<<original>>

acpi_status
acpi_os_table_override (acpi_table_header *existing_table, 
acpi_table_header **new_table)
{
         if (!existing_table || !new_table)
                 return AE_BAD_PARAMETER;

         *new_table = NULL;
         return AE_OK;
}

<<patched>>

acpi_status
acpi_os_table_override (acpi_table_header *existing_table, 
acpi_table_header **new_table)
{
         if (!existing_table || !new_table)
                 return AE_BAD_PARAMETER;

         *new_table = NULL;
         if (strncmp(existing_table->signature, "DSDT", 4) == 0)
                 *new_table = (acpi_table_header*)AmlCode;
         else
                 *new_table = NULL;
         return AE_OK;
}

I hope this will help. Please tell me whether you had success ;-)

Regards
Heiko



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
