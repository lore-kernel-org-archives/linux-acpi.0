From: Hiroyuki KAMEZAWA <kamezawa.hiroyu-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [Lhms-devel] [PATCH] ACPI based Memory Hotplug Driver Patch
 Update
Date: Wed, 13 Oct 2004 16:04:08 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <416CD368.3060807@jp.fujitsu.com>
References: <FEB6C4E97F6CAF41978FB2059D5454180F3916@bgsmsx402.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <FEB6C4E97F6CAF41978FB2059D5454180F3916-OkeUvhg1trkFyVwBAnZdSLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "S, Naveen B" <naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Tolentino, Matthew E" <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

S, Naveen B wrote:

>
> Thanks Kame,
> As I was mentioning earlier, my understanding from the spec that the
> memory device has only range in _CRS. So I believe acpi_walk_resources
> is redundant in this case. Anyway this could be changed if it is a real
> concern.
> Please let me know.
> 
> --Naveen
> 

Okay, thanks.
Currently, I have no *real* concern.

-- Kame <kamezawa.hiroyu-+CUm20s59erQFUHtdCDX3A@public.gmane.org>


> 
> 
>>S, Naveen B wrote:
>>+static int
>>+acpi_memory_enable_device(struct acpi_memory_device *mem_device)
>>+{
>>+	int result;
>>+
>>+	ACPI_FUNCTION_TRACE("acpi_memory_enable_device");
>>+
>>+	/* Get the range from the _CRS */
>>+	result = acpi_memory_get_device_resources(mem_device);
>>
>>result = acpi_walk_resources(mem_device->handle, METHOD_NAME_CRS,
>>                              acpi_memory_get_device_resources,
>>mem_device);
>>
>>+	if (result) {
>>+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
>>+			"\nget_device_resources failed\n"));
>>+		mem_device->state = MEMORY_INVALID_STATE;
>>+		return result;
>>+	}
>>
>>--
>>--the clue is these footmarks leading to the door.--
>>KAMEZAWA Hiroyuki <kamezawa.hiroyu-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
> 
> 
> 


-- 
--the clue is these footmarks leading to the door.--
KAMEZAWA Hiroyuki <kamezawa.hiroyu-+CUm20s59erQFUHtdCDX3A@public.gmane.org>



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
