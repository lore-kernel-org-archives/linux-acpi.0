From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2] platform/x86: wmi-bmof: New driver to expose embedded
 Binary WMI MOF metadata
Date: Thu, 23 Nov 2017 06:48:05 -0800
Message-ID: <CALCETrVEDtgNBqn=ZxxcD-kGWSm_Pyuo7+jfb+pPrpe9boRc6w@mail.gmail.com>
References: <cd020900567e5c26af29e0735a3945a855d26a30.1496718529.git.dvhart@infradead.org>
 <20170606100440.GA4690@pali> <20170606170201.GC32509@fury>
 <201706062250.52564@pali> <20170704132819.GE2102@pali> <20171123143914.mib63w4amwmnjfxa@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171123143914.mib63w4amwmnjfxa@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Lutomirski <luto@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mario Limonciello <mario_limonciello@dell.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 23, 2017 at 6:39 AM, Pali Rohár <pali.rohar@gmail.com> wrote:
> On Tuesday 04 July 2017 15:28:19 Pali Rohár wrote:
>> On Tuesday 06 June 2017 22:50:52 Pali Rohár wrote:
>> > On Tuesday 06 June 2017 19:02:01 Darren Hart wrote:
>> > > On Tue, Jun 06, 2017 at 12:04:40PM +0200, Pali Rohár wrote:
>> > > > On Monday 05 June 2017 20:16:44 Andy Lutomirski wrote:
>> > > > > +#define WMI_BMOF_GUID "05901221-D566-11D1-B2F0-00A0C9062910"
>> > > > > +MODULE_ALIAS("wmi:" WMI_BMOF_GUID);
>> > > >
>> > > > Cannot we generate MODULE_ALIAS from module_wmi_driver()? IIRC it
>> > > > is working for i2c drivers.
>> > >
>> > > I could see this being automated since we always use wmi:GUID, but it
>> > > isn't currently. Happy to consider it as a follow on.
>> > >
>> > > Do you have a specific i2c example you think we should consider
>> > > following?
>> >
>> > For i2c you can specify in driver code:
>> >
>> > MODULE_DEVICE_TABLE(i2c, id_table);
>> >
>> > And it automatically provides (via file.mod.c) all needed MODULE_ALIAS.
>> >
>> > So when we have wmi_bmof_id_table in driver, cannot we use this?
>> >
>> > MODULE_DEVICE_TABLE(wmi, wmi_bmof_id_table);
>>
>> Just reminder for above idea ↑↑↑
>
> Hi! This email is some months old, so do not know if something was
> implemented or not. Does somebody know?
>

I don't think so.  I was way too lazy.
