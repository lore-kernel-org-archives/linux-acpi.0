From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v5 05/11] platform/x86: intel_pmc: Make PCI dependency
 explicit
Date: Fri, 4 Jan 2019 10:07:18 -0500
Message-ID: <3d6835d2-5064-630f-4e54-49a64bffc58b@kernel.org>
References: <20190102181038.4418-1-okaya@kernel.org>
 <20190102181038.4418-6-okaya@kernel.org>
 <CAHp75VfGe=rdN0JeLoHnPM0XuVunH5RvAmMEqbxFPWA7BmkzEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfGe=rdN0JeLoHnPM0XuVunH5RvAmMEqbxFPWA7BmkzEw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Kuppuswamy Sathyanarayanan <sathyanarayanan.kupuswamy@linux.intel.com>, "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Cc: linux-next <linux-next@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 1/4/2019 9:20 AM, Andy Shevchenko wrote:
> Unfortunately, this is not how it should be fixed.
> 
> First of all, we (Heikki, Sathya, me —  all in Cc list) that this
> driver should be refactored and unified with intel_scu_ipc.
> Then, it has two drivers inside and PCI is just a glue for it which is
> optional. Thus, needs to be split accordingly.

OK. Two questions:

1. How should I change this now?
2. Can you change the Kconfig accordingly after you merge the two drivers?

I'm focused on the build failure at this moment.
