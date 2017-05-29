From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH] acpi: configfs: Unload SSDT on configfs entry removal
Date: Mon, 29 May 2017 14:53:11 +0200
Message-ID: <fff98a5c-e18f-d326-e5de-7401173d9af4@siemens.com>
References: <5f535371-1053-09c3-25b4-0b75a79a0ff5@siemens.com>
 <20170529124755.GR2784@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170529124755.GR2784@lahna.fi.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devel@acpica.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

On 2017-05-29 14:47, Mika Westerberg wrote:
> On Mon, May 29, 2017 at 01:33:29PM +0200, Jan Kiszka wrote:
>> Enhance acpi_load_table to also return the table index. Use that index
>> to unload the table again when the corresponding directory in configfs
>> gets removed. This allows to change SSDTs without rebooting the system.
>> It also allows to destroy devices again that a dynamically loaded SSDT
>> created.
>>
>> This is widely similar to the DT overlay behavior.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> Can someone explain to me why an unloaded table still sticks around in
>> sysfs and why we cannot release its ID and rather have to use a new one
>> when loading a modified version?
> 
> IIRC ACPICA relies the fact that SSDTs are never unloaded. Bob (CC'd)
> can correct me if I got it wrong.

OK... Is that standard-driven or just a limitation of this implementation?

Is there an upper limit of tables? I'm thinking of lengthy development
sessions that play with tables, loading and unloading modified versions.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
