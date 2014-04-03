From: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
Subject: Re: How to pass I2C platform_data under ACPI
Date: Thu, 3 Apr 2014 14:12:40 +0300
Message-ID: <20140403111240.GC19349@intel.com>
References: <D854C92F57B1B347B57E531E78D05EAD57463568@BGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <D854C92F57B1B347B57E531E78D05EAD57463568@BGSMSX104.gar.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Pallala, Ramakrishna" <ramakrishna.pallala@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Apr 03, 2014 at 08:10:40AM +0000, Pallala, Ramakrishna wrote:
> Hi All,
> 
> I am trying to enable a i2c client driver under ACPI. The device is being enumerated behind adapter device and I am getting IRQ resource as well.
> 
> The problem I have now is, how do I pass the platform data to driver?
> 
> struct i2c_board_info {
>         char            type[I2C_NAME_SIZE];
>         unsigned short  flags;
>         unsigned short  addr;
>         void            *platform_data; ===========> how can I initialize this filed.
>         struct dev_archdata     *archdata;
>         struct device_node *of_node;
>         struct acpi_dev_node acpi_node;
>         int             irq;
> };
>  
> In non ACPI environment I used to initialize the platform_data under
> board or platforms files. Under ACPI how do I do that?

If you can't extract that information from ACPI namespace, then one option
is to pass platform data along with the device ACPI ID:

static const struct acpi_device_id my_acpi_match[] = {
	{ "MYID0001", (kernel_ulong_t)&my_platform_data }
	...
	{ },
};

static struct i2c_driver i2c_hid_driver = {
        .driver = {
		...
                .acpi_match_table = ACPI_PTR(my_acpi_match),
        },
...
