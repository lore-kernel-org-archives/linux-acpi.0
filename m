From: Kylene Hall <kjhall-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: Looking for the correct way to retrieve ACPI table info
Date: Wed, 02 Mar 2005 09:08:46 -0600
Message-ID: <1109776126.3201.9.camel@jo.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Seiji Munetoh <MUNETOH-JE5g2YyFxFHQT0dZR+AlfA@public.gmane.org>, Tom Lendacky <toml-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, Emily Ratliff <emilyr-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, Kent E Yoder <yoder1-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hello-

We are working on a device driver for the Trusted Computing Group TPM.
BIOS has been augmented to created a log of TCG boot events and
userspace needs to read these events.  We plan for the driver to export
them via sysfs, therefore we need to call acpi_os_map_memory and the
corresponding acpi_os_unmap memory.  Would it be ok to export these
functions?  Would you recommend some other interface which is already
exported or would be better to export.  Currently we call
acpi_get_firmware_table with a signature of "TCPA"  and a pointer to a
structure like:
                struct acpi_tcpa {
                  struct acpi_table_header hdr;
                  u16 reserved;
                  u32 log_max_len PACK;
                  u32 log_start_addr PACK;
                };
The log_man_len and log_start_addr fields are then passed to the
acpi_os_map_memory function and we retrieve the data.


Please let me know your feelings on this approach and the wording of
this note.  Sorry for note circulating this conversation wider earlier
and saving you the work you have already done on these patches.

Thanks,
Kylie Hall

-- 
Kylene Hall
IBM Linux Technology Center




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
