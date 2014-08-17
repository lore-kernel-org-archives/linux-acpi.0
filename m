From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [RFC PATCH 6/9] gpiolib: add API to get gpio desc and flags
Date: Sun, 17 Aug 2014 12:43:38 -0500
Message-ID: <D016516D.A1AFA%dvhart@linux.intel.com>
References: <1408255459-17625-1-git-send-email-mika.westerberg@linux.intel.com>
 <1408255459-17625-7-git-send-email-mika.westerberg@linux.intel.com>
 <20140817130004.4B9FDC4137F@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140817130004.4B9FDC4137F@trevor.secretlab.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Aaron Lu <aaron.lu@intel.com>, Max Eliaser <max.eliaser@intel.com>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 8/17/14, 6:00, "Grant Likely" <grant.likely@secretlab.ca> wrote:

>>
>>+	/* Using device tree? */
>>+	if (IS_ENABLED(CONFIG_OF) && dev->of_node)
>>+		desc = of_find_gpio(dev, NULL, idx, flags);
>
>of_find_gpio() doesn't exist.

Hrm... As of 3.16.0 (e64df3ebe8262c8203d1fe4f541e0241c3112c01)

$ git blame -L1455,1456 drivers/gpio/gpiolib.c
bae48da2 (Alexandre Courbot 2013-10-17 10:21:38 -0700 1455) static struct
gpio_desc *of_find_gpio(struct device *dev, const char *con_id,

Have we removed this in -next or something? (on the plane, will verify
upon landing)



-- 
Darren Hart					Open Source Technology Center
darren.hart@intel.com				            Intel Corporation
