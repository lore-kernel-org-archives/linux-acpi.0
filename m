From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] ACPI: Use acpi_os_allocate_zeroed instead of acpi_os_allocate + memset
Date: Tue, 08 Apr 2014 14:33:39 +0200
Message-ID: <3860698.PuFggScD3D@vostro.rjw.lan>
References: <000101cf440f$07eb40d0$17c1c270$%choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55219 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756141AbaDHMRk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Apr 2014 08:17:40 -0400
In-Reply-To: <000101cf440f$07eb40d0$17c1c270$%choi@samsung.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonghwan Choi <jhbird.choi@samsung.com>
Cc: linux-acpi@vger.kernel.org, 'Len Brown' <lenb@kernel.org>

On Thursday, March 20, 2014 04:35:56 PM Jonghwan Choi wrote:
> This is a multi-part message in MIME format.
> 
> ------=_NextPart_000_0002_01CF445A.77D2E8D0
> Content-Type: text/plain;
> 	charset="us-ascii"
> Content-Transfer-Encoding: 7bit
> 
> Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>

Queued up for the next ACPI pull request, thanks!

> ---
>  drivers/acpi/osl.c   |    3 +--
>  drivers/acpi/utils.c |    3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index fc1aa79..09e53be 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -1221,10 +1221,9 @@ acpi_os_create_semaphore(u32 max_units, u32
> initial_units, acpi_handle * handle)
>  {
>  	struct semaphore *sem = NULL;
>  
> -	sem = acpi_os_allocate(sizeof(struct semaphore));
> +	sem = acpi_os_allocate_zeroed(sizeof(struct semaphore));
>  	if (!sem)
>  		return AE_NO_MEMORY;
> -	memset(sem, 0, sizeof(struct semaphore));
>  
>  	sema_init(sem, initial_units);
>  
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index 85e3b61..84453fe 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -164,11 +164,10 @@ acpi_extract_package(union acpi_object *package,
>  	 * Validate output buffer.
>  	 */
>  	if (buffer->length == ACPI_ALLOCATE_BUFFER) {
> -		buffer->pointer = ACPI_ALLOCATE(size_required);
> +		buffer->pointer = ACPI_ALLOCATE_ZEROED(size_required);
>  		if (!buffer->pointer)
>  			return AE_NO_MEMORY;
>  		buffer->length = size_required;
> -		memset(buffer->pointer, 0, size_required);
>  	} else {
>  		if (buffer->length < size_required) {
>  			buffer->length = size_required;
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
