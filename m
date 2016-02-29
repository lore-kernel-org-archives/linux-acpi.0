From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 1/2] gpio: designware: switch device node to fwnode
Date: Mon, 29 Feb 2016 12:46:26 +0200
Message-ID: <CAHp75VftQyf6gMvi6mdWkku8+K9GrgtPrZ-819XjBQwF2AY3yw@mail.gmail.com>
References: <1456317210-42742-1-git-send-email-qiujiang@huawei.com>
	<1456317210-42742-2-git-send-email-qiujiang@huawei.com>
	<CAHp75Vd4dNJpuiMMizYbOpv+pZd30RcNA+kPoF6_4Vukk62iFw@mail.gmail.com>
	<56CEEC58.9050303@huawei.com>
	<CAHp75Vecxx+YBrZ9d4oZzqS_X3cxUQ4UaSvjqjhuaoJ4O9xauw@mail.gmail.com>
	<56D14D1C.6090706@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:35246 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753340AbcB2Kq1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Feb 2016 05:46:27 -0500
In-Reply-To: <56D14D1C.6090706@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: qiujiang <qiujiang@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com

On Sat, Feb 27, 2016 at 9:15 AM, Jiang Qiu <qiujiang@huawei.com> wrote:

>>>>> -       node = dev->of_node;
>>>>> -       if (!IS_ENABLED(CONFIG_OF_GPIO) || !node)
>>>>> +       if (!IS_ENABLED(CONFIG_OF_GPIO) || !(dev->of_node))
>>>>>                 return ERR_PTR(-ENODEV);
>>>>
>>>> So, since you converted to fwnode, do you still need this check?
>>>>
>>> Although this patch coverted device node to fwnode, only DTs binding was
>>> supported here, and patch2 support ACPI will remove this check.
>>
>> Yes, but like I said below device_get_child_node_count() will take
>> care of that, will it?
> Right, device_get_child_node_count() will take of it, this should be removed.
>>
>>>>>
>>>>> -       nports = of_get_child_count(node);
>>>>> +       nports = device_get_child_node_count(dev);
>>>>>         if (nports == 0)
>>>>>                 return ERR_PTR(-ENODEV);
>>>>
>>>> ...I think this one fail if it will not found any child.
>>> This one fail? yes, it will return to failure.
>>> I am not very clear here.
>>
>> See above.
> Here, device_get_child_node_count will return ZERO if there is not any child.
> So, I think this will work ok, will it?

I didn't check deeply, but I assume so.


-- 
With Best Regards,
Andy Shevchenko
