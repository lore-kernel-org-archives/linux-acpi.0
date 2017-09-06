From: Meng Xu <mengxu.gatech@gmail.com>
Subject: Re: [PATCH] acpi: fix potential double-fetch bug
Date: Wed, 6 Sep 2017 09:59:47 -0400
Message-ID: <0779b159-1986-8dd6-5fc6-425aca41ab2e@gmail.com>
References: <1503522449-35440-1-git-send-email-meng.xu@gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503522449-35440-1-git-send-email-meng.xu@gatech.edu>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: sanidhya@gatech.edu, taesoo@gatech.edu
List-Id: linux-acpi@vger.kernel.org

Hi Rafael and Len,

I have found a potential double-fetch operation (a TOCTOU case)
in acpi/custom_method.c, which is explained in detail in the
previous email. I'd like to seek your opinion about the patch
I proposed and also your opinion about this problem in general.

The other two modules that have the same problem
has been acknowledged and fixed:

perf/core.c
https://marc.info/?l=linux-kernel&m=150442907017508&w=2

drivers/nvdimm/bus.c
https://marc.info/?l=linux-kernel&m=150454910315948&w=2

Best Regards,
Meng

On 08/23/2017 05:07 PM, Meng Xu wrote:
> From: Meng Xu <mengxu.gatech@gmail.com>
>
> While examining the kernel source code, I found a dangerous operation that
> could turn into a double-fetch situation (a race condition bug) where
> the same userspace memory region are fetched twice into kernel with sanity
> checks after the first fetch while missing checks after the second fetch.
>
> In the case of *ppos == 0:
>
> 1. The first fetch happens in line 36
> copy_from_user(&table, user_buf, sizeof(struct acpi_table_header)))
>
> 2. Subsequently `table.length` variable is used to allocate the `buf`drivers/acpi/custom_method.c
>
> (line 40).
>
> 3. The second fetch happens in line 54
> copy_from_user(buf + (*ppos), user_buf, count)
>
> 4. Given that `user_buf` can be fully controlled in userspace, an attacker can
> race condition to override the header part of `user_buf`, say,
> `((struct acpi_table_header *)user_buf)->length` to arbitrary value
> (say 0xFFFFFFFF) after the first fetch but before the second fetch. The changed
> value will be copied to `buf`.
>
> 5. There is no checks on `((struct acpi_table_header *)buf)->length` until the
> use of it in line 64 status = acpi_install_method(buf), which means that the
> assumed relation, `buf->length` == length of the buffer, might not hold after
> the second fetch. And once the control goes to function `acpi_install_method`,
> we lose the context to assert that.
>
> 6. It is lucky that `buf->length` is not used in function `acpi_install_method`
> so, there is no working exploit against it right now. However, this could
> easily turns to an exploitable one if careless developers start to use
> `buf->length` later.
>
> Proposed patch:
>
> The patch explicitly overrides `buf->length` after the second fetch with the
> value `max_size` from the first fetch. In this way, it is assured that the
> relation, `buf->length` == length of the buffer, holds after the second fetch.
>
> Signed-off-by: Meng Xu <mengxu.gatech@gmail.com>
> ---
>   drivers/acpi/custom_method.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
> index c68e724..eea7986 100644
> --- a/drivers/acpi/custom_method.c
> +++ b/drivers/acpi/custom_method.c
> @@ -57,6 +57,13 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
>   		return -EFAULT;
>   	}
>   
> +	if (!(*ppos)) {
> +		struct acpi_table_header *hdr =
> +			ACPI_CAST_PTR(struct acpi_table_header, buf);
> +
> +		hdr->length = max_size;
> +	}
> +
>   	uncopied_bytes -= count;
>   	*ppos += count;
>   
