From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: Fan not working after hibernate but ok after
 s2ram?
Date: Sat, 13 Oct 2007 02:38:16 +0400
Message-ID: <470FF758.40106@suse.de>
References: <1192224624.7038.9.camel@rukbat> <200710130007.34842.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200710130007.34842.rjw@sisk.pl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: suspend-devel@lists.sourceforge.net, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Rafael J. Wysocki wrote:
> Greetings,
> 
> On Friday, 12 October 2007 23:30, Romano Giannetti wrote:
>> Hi,
>>
>> 	I have a strange problem. I am running 2.6.23 on a toshiba satellite
>> 2.6.23, I use s2ram to suspend and echo disk > ... to hibernate. System
>> is ubuntu Feisty.
>>
>> 	Now, both s2ram -f -p -m and hibernte works ok, but after resuming from
>> hibernation, the fan of the laptop seems never to start again (it is ok
>> after resuming from s2ram). I rebooted the system now (it arrived at 80
>> celsius without starting the fan, normally it starts at 60) because I do
>> not want to have a fried laptop...
> 
> Sure.
> 
>> 	Any hints? I tried to rmmod/insmod again fan.ko but it didn't help.
There is 3 patch series in linux-acpi mail list, which might be related:
[PATCH 1/3] ACPI: power: don't cache power resource state
[PATCH 2/3] ACPI: Fan: fan device does not need own structure
[PATCH 3/3] ACPI: Fan: Drop force_power_state acpi_device option

Alex.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
