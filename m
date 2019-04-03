From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Apr 3 (acpi_dev_get_first_match*)
Date: Wed, 3 Apr 2019 08:20:15 -0700
Message-ID: <532f66c8-4c25-10d3-d119-71f3c8f82edd@infradead.org>
References: <20190403192407.13a99513@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403192407.13a99513@canb.auug.org.au>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 4/3/19 1:24 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190402:
> 

on i386 or x86_64:

The patch(es) that change acpi_dev_get_first_match_name() to
acpi_dev_get_first_match_dev() have a problem when CONFIG_ACPI is not set/enabled.


../drivers/gpio/gpio-merrifield.c: In function ‘mrfld_gpio_get_pinctrl_dev_name’:
../drivers/gpio/gpio-merrifield.c:388:19: error: dereferencing pointer to incomplete type
   put_device(&adev->dev);
                   ^

../drivers/extcon/extcon-axp288.c: In function ‘axp288_extcon_probe’:
../drivers/extcon/extcon-axp288.c:363:20: error: dereferencing pointer to incomplete type
    put_device(&adev->dev);
                    ^


-- 
~Randy
