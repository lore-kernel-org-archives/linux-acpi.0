From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Re: Machine no longer enters C3 on 2.6.11-rc1-bk
Date: Thu, 20 Jan 2005 09:25:15 -0500
Message-ID: <41EFBF4B.80206@bartol.udel.edu>
References: <20050120104033.GA25889@elf.ucw.cz> <16879.36609.94551.926755@aber.ac.uk> <20050120105911.GF1452@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050120105911.GF1452-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>> > bus master activity: is changing all the time, mostly 555555555 and
>> > aaaaaaa, and cpu refuses to enter C3 for obvious reasons. I compiled
>> > out USB and sound... Does anybody else see the same problem?
>> > 
>>
>>I did notice too that it was never in C3 apart from a bit right at the
>>beginning, since 2.6.10.  It has always been like that up to 2.6.6, became
>>better from 2.6.7 (but had other problems with that).
> 
> 
> Good, so I'm not alone.
> 

I see the same thing. Furthermore, my CPU never appears to enter C1 
either (except at the beginning). Is this aspect of the behaviour normal?

By the way, the bus master activity always appears as ffffffff.

cheers,

Rich


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
