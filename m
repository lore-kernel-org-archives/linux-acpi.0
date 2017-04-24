From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] ACPI / GED: use late init to allow other drivers init
Date: Mon, 24 Apr 2017 19:33:11 -0400
Message-ID: <3f0f2853-d2e5-be32-2bde-47e72c51a0a6@codeaurora.org>
References: <1492813704-32280-1-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0gtLajqCsw0HTS=sL_=cU1aSFzUk6e_kAPAfreuCpak7g@mail.gmail.com>
 <bf1ce91f-b232-4dce-5ed7-597b0ef46f92@codeaurora.org>
 <CAJZ5v0jaGnoCjiU6VuHLyy9Kug8nHzxPxP8tuy3kphtfgmW38w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41962 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S978746AbdDXXdO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Apr 2017 19:33:14 -0400
In-Reply-To: <CAJZ5v0jaGnoCjiU6VuHLyy9Kug8nHzxPxP8tuy3kphtfgmW38w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Rafael,

On 4/24/2017 7:01 PM, Rafael J. Wysocki wrote:
> On Sat, Apr 22, 2017 at 12:48 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> On 4/21/2017 6:43 PM, Rafael J. Wysocki wrote:
>>>> +late_initcall(ged_init);
>>> Does this fix the problem?
>>>
>>> What about if the module in question is loaded after running late_initcalls?
>>
>> This fixed the issue for me where I had dependencies for QUP I2C driver and GHES
>> drivers. Both of them are modules and get probed via normal module execution path.
>>
>> However, I'm open to improvements.  Do you have a better suggestion? I can try
>> to add some _DEP stuff if it is present, but I remember Linux doesn't like _DEP
>> stuff too much.
> 
> My point is that nothing guarantees a specific ordering or timing of
> module loading in general, so moving stuff to different initcall
> levels does not really help 100% of the time.
> 

I was thinking about this today. I agree that this is not a complete solution.

I'm interested in drivers that are either built-in or present in the initramfs.
Drivers that participate in GED work are considered essential drivers. I expect
these essential drivers to be present in early boot phase. 

I can certainly improve the commit message.

As long as the drivers are built-in or available in initramfs, I expect this to work. 
I want to focus on this use case. 

static char *initcall_level_names[] __initdata = {
        "early",
        "core",
        "postcore",
        "arch",
        "subsys",
        "fs",
        "device",
        "late",
};

static void __init do_initcall_level(int level)
{
...
        for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++)
                do_one_initcall(*fn);
}

Given these constraints, doesn't this guarantee the order of initialization for built-in and
initramfs modules?

Of course, this won't also play nice with another driver module that requires late_init.
Maybe, this is 1% of the case. 

If the driver gets pulled in from the rootfs via modules.conf, then this will definitely
not work as you indicated. 

My proposal is to explore the presence of _DEP to reach to %100. Here is an example

GED OBJECT
{
	Name(_DEP, "Some other object")
}

I see that ACPI core checks the presence of _DEP value in acpi_device_dep_initialize() 
and it won't load the GED driver until dependencies are met if I got it right.

acpi_walk_dep_device_list() gets called from external drivers that need to unblock
the dependent object. acpi_gpiochip_add() seems to take care of this for GPIO.
i2c_acpi_install_space_handler() seems to take care of this for I2C. 

We can potentially add acpi_walk_dep_device_list() to GHES driver for completeness.
Then, all FW needs to do is set up a dependency from GED object to its required objects.

Please let me know if I'm missing something. 


> Thanks,
> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
