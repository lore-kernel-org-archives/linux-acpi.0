From: =?UTF-8?Q?Thomas_Sch=c3=b6bel-Theuer?= <thomas@schoebel-theuer.de>
Subject: Re: [PATCH] acpi / apei: fix NULL deref during init
Date: Fri, 14 Dec 2018 23:42:01 +0100
Message-ID: <5ec69dad-7943-343b-5ced-9a962652e14c@schoebel-theuer.de>
References: <20181214181514.29891-1-tst@schoebel-theuer.de>
 <20181214202406.GI11710@zn.tnic>
 <c8d62037-4a26-e18b-51a3-73fc99e76e5b@schoebel-theuer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c8d62037-4a26-e18b-51a3-73fc99e76e5b@schoebel-theuer.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Schoebel-Theuer <tst@schoebel-theuer.de>, Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, Laura Abbott <labbott@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 12/14/18 22:27, Thomas Schoebel-Theuer wrote:
> On 12/14/18 21:24, Borislav Petkov wrote:
>>
>> Because apei_resources_fini() happens under the same condition check and
>> if arch_apei_filter_addr was false, it should not become true, all of a
>> sudden. Or?
>
> please take a look at the stacktrace. For some reason, and only at 
> that specific hardware, the condition is false, there but later the 
> indicated error exit is taken whose message you can see immediately 
> before the stack trace.
>

Ah, I overlooked that commit e56c92565dfe2 is already providing a 
different solution to the same problem in newer kernels _only_, as a 
_side_ effect (not clear to me from the description, but clear from 
reading the code).

But this patch is not present at the 4.4.166 kernel where I found the 
problem and fixed it internally in a different way.

The 4.4.166 code looks like this, without the if-statement you are 
mentioning, unconditionally trying to free the unitinialized variable 
under certain circumstances:

d91525eb8ee6a (Chen, Gong     2014-12-10 13:53:26 -0800 553) arch_res_fini:
d91525eb8ee6a (Chen, Gong     2014-12-10 13:53:26 -0800 554) 
apei_resources_fini(&arch_res);
d91525eb8ee6a (Chen, Gong     2014-12-10 13:53:26 -0800 555) nvs_res_fini:
4134b8c8811f2 (Huang Ying     2011-12-08 11:25:50 +0800 556) 
apei_resources_fini(&nvs_resources);
23f124ca3dda9 (Huang Ying     2010-09-29 19:53:54 +0800 557) return rc;

So another alternative would be backporting e56c92565dfe2 to the 4.4 LTS 
series. Also fine for me.
