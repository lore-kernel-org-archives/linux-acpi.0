From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] ACPI / GED: unregister interrupts during shutdown
Date: Thu, 7 Dec 2017 12:18:57 -0500
Message-ID: <20707334-001e-f138-59af-a23cdee05737@codeaurora.org>
References: <1512507705-2411-1-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0hEdK_vJcHeoz=Z2H6od=bktspPpTo37Y6qiOT2qptnaA@mail.gmail.com>
 <20171207082958.GA11882@kroah.com> <2960222.F3CtrQ5k26@aspire.rjw.lan>
 <e17a3ac6-aac3-09ee-7307-01ddc780507a@codeaurora.org>
 <CAJZ5v0g7APeWHkL+c5LT7sx4xpZn=TxCSpt5y=DU7yOiyUkNRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0g7APeWHkL+c5LT7sx4xpZn=TxCSpt5y=DU7yOiyUkNRg@mail.gmail.com>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, linux-arm-msm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 12/7/2017 12:10 PM, Rafael J. Wysocki wrote:
>> My take away from the discussion is:
>> 1. don't use devm family of functions for IRQ registration/free
>> 2. still keep track of the events
>> 3. call free_irq on shutdown.
> Yes.  And on remove too.

OK, will make the changes and post a newer version. Thanks for the
confirmation.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
