From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/30] ACPI-processor: Improve two size determinations in
 acpi_processor_get_performance_states()
Date: Sat, 10 Sep 2016 13:47:28 +0200
Message-ID: <20160910114728.gyx6hv73tvhn44fu@pd.tnic>
References: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
 <b24c70c2-7b8f-26e2-6ceb-7eab56a73a28@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:40827 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752058AbcIJLyd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 10 Sep 2016 07:54:33 -0400
Content-Disposition: inline
In-Reply-To: <b24c70c2-7b8f-26e2-6ceb-7eab56a73a28@users.sourceforge.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

On Sat, Sep 10, 2016 at 11:36:41AM +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 6 Sep 2016 11:11:12 +0200
> 
> Replace the specification of a data structure by pointer dereferences
> as the parameter for the operator "sizeof" to make the corresponding size
> determination a bit safer according to the Linux coding style convention.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/acpi/processor_perflib.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
> index 78f9025..004e24c 100644
> --- a/drivers/acpi/processor_perflib.c
> +++ b/drivers/acpi/processor_perflib.c
> @@ -358,7 +358,7 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
>  
>  		struct acpi_processor_px *px = &(pr->performance->states[i]);
>  
> -		state.length = sizeof(struct acpi_processor_px);
> +		state.length = sizeof(*px);

How is this better?

Now the person reading the code has to go and lookup what px is in order
to know what its size is and which goes in there. Sure, it is a couple
of lines up but this is not always the case...

>  		state.pointer = px;
>  
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Extracting state %d\n", i));
> @@ -400,7 +400,8 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
>  				 * Copy this valid entry over last_invalid entry
>  				 */
>  				memcpy(&(pr->performance->states[last_invalid]),
> -				       px, sizeof(struct acpi_processor_px));
> +				       px,
> +				       sizeof(*px));
>  				++last_invalid;

... like here, for example.

In any case, I won't take this one if I were the maintainer.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
