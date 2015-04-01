From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH v2] Documentation: gpio: Update ACPI part of the document
 to mention _DSD
Date: Wed, 01 Apr 2015 09:16:25 -0700
Message-ID: <D141679C.C4BF1%dvhart@linux.intel.com>
References: <1427875996-216926-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1427875996-216926-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 4/1/15, 1:13 AM, "Mika Westerberg" <mika.westerberg@linux.intel.com>
wrote:

>With ACPI 5.1 _DSD (Device Specific Data) it is now possible to name
>functions just like Device Tree is doing. Make sure that the documentation
>mentions _DSD as the recommended way to describe GPIOs in ACPI systems.
>
>Reported-by: Darren Hart <dvhart@linux.intel.com>
>Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>---
>v2: Corrected text according what Darren suggested

Thanks Mika,

Reviewed-by: Darren Hart <dvhart@linux.intel.com>

-- 
Darren Hart
Intel Open Source Technology Center



