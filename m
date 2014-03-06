From: Juan Manuel Cabo <juanmanuel.cabo@gmail.com>
Subject: Re: [PATCH v2] ACPI / EC: Clear stale EC events on Samsung systems
Date: Wed, 05 Mar 2014 22:36:05 -0300
Message-ID: <5317D105.6050206@gmail.com>
References: <1393429360-4344-1-git-send-email-clancy.kieran@gmail.com> <53176D59.3030602@canonical.com> <CAGf84Q+7=abgk78WuhNWdy+3kgXma1fHj6OPk9ytQ4kFzcoFJA@mail.gmail.com> <1885040.WKp5oRmh5C@vostro.rjw.lan> <CAGf84QK-N+C6eHct4XDzOCHwfN649F2okJ1y2V70wWz-wHFKEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGf84QK-N+C6eHct4XDzOCHwfN649F2okJ1y2V70wWz-wHFKEA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kieran Clancy <clancy.kieran@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Joseph Salisbury <joseph.salisbury@canonical.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Li Guang <lig.fnst@cn.fujitsu.com>, Lan Tianyu <tianyu.lan@intel.com>, Dennis Jansen <dennis.jansen@web.de>
List-Id: linux-acpi@vger.kernel.org

Beware, the context line:        
             static struct dmi_system_id ec_dmi_table[] __initdata = {
has changed in recent kernels, so that line of the patch would need
to be different for it to apply older kernels.
It used to be this:
             static struct dmi_system_id __initdata ec_dmi_table[] = {
until 3.11 I guess.

It is just a context line and is not important for the patch itself.

See:
http://lxr.free-electrons.com/source/drivers/acpi/ec.c?v=3.11
http://lxr.free-electrons.com/source/drivers/acpi/ec.c?v=3.12

Cheers!
--Juan Manuel Cabo


On 03/05/2014 10:24 PM, Kieran Clancy wrote:
> On Thu, Mar 6, 2014 at 11:22 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Thursday, March 06, 2014 11:04:14 AM Kieran Clancy wrote:
>>> Rafael, is it a separate process to get this in the stable tree or
>>> will it naturally happen after being merged into the mainline?
>> I need to add a proper "CC stable" tag to your patch for this to happen.
>>
>> Which -stable kernels should it go to?
> 3.2 and 3.10 seem like natural choices (3.4?), but I don't know the
> norm for this kind of fix. Would there be any reason not to include it
> in some particular stable kernels?
>
> Cheers,
> Kieran.
>
