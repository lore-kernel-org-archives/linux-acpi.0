From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ACPI / LPSS: Only call pwm_add_table for the first PWM
 controller
Date: Thu, 6 Jul 2017 20:50:03 +0200
Message-ID: <d1b8bd66-692a-bbb4-9015-c0de27cb8321@redhat.com>
References: <20170706164927.15076-1-hdegoede@redhat.com>
 <1499361099.22624.292.camel@linux.intel.com>
 <5a6aa544-fbe5-6eb2-901f-39a3814cea1d@redhat.com>
 <1499365144.22624.296.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1499365144.22624.296.camel@linux.intel.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On 06-07-17 20:19, Andy Shevchenko wrote:
> On Thu, 2017-07-06 at 20:08 +0200, Hans de Goede wrote:
>> On 06-07-17 19:11, Andy Shevchenko wrote:
>>> On Thu, 2017-07-06 at 18:49 +0200, Hans de Goede wrote:
>>>>
> 
>>> By the way, do you need a shell script that allows to setup pin
>>> muxing
>>> via external CPLD?
>>
>> Thanks, but no thanks I don't want to make physical alterations to
>> my boards.
> 
> I surprised it works for you by default. I have UP board (BIOS v0.4)
> which doesn't provide any useful output since CPLD is configured by BIOS
> to most safe state.

Ah, I did not understand this script is specific to the UP,
I don't have a UP, the reporter of the problem does :)

Regards,

Hans
