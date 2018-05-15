From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: Re: [PATCH v5 1/2] clk: x86: Add ST oscout platform clock
Date: Tue, 15 May 2018 15:09:08 +0530
Message-ID: <9f31fc22-b97f-0241-30cd-798ee03b2f1d@amd.com>
References: <1525859941-23654-1-git-send-email-akshu.agrawal@amd.com>
 <1525859941-23654-2-git-send-email-akshu.agrawal@amd.com>
 <20362702.FCbsg9xPKv@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20362702.FCbsg9xPKv@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: djkurtz@chromium.org, Alexander.Deucher@amd.com, mturquette@baylibre.com, sboyd@kernel.org, christian.koenig@amd.com, airlied@redhat.com, Shaoyun.Liu@amd.com, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org



On 5/15/2018 3:02 PM, Rafael J. Wysocki wrote:
> On Wednesday, May 9, 2018 11:59:00 AM CEST Akshu Agrawal wrote:
>> Stoney SoC provides oscout clock. This clock can support 25Mhz and
>> 48Mhz of frequency.
>> The clock is available for general system use.
>>
>> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> 
> I'm not sure if the Stephen Boyd's comments on one of the previous
> versions of this patch have been addressed.  Have they?
> 
> In any case, if I'm expected to take this, I need an ACK from Stephen on it.
> 
> Thanks,
> Rafael
> 

All comments of Stephen Boyd and Daniel Kurtz have been addressed.

Stephen, if you are Ok with this can you please ACK it.

Thanks,
Akshu
