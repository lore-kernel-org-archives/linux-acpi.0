From: Renato Golin <rengolin@gmail.com>
Subject: Re: Toshiba Equium L20
Date: Wed, 15 Feb 2006 13:20:20 +0000
Message-ID: <d9b9d95f0602150520j72e0e89ai883f1118cd662c65@mail.gmail.com>
References: <1140001153.8856.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.206]:14485 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1945934AbWBONUW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Feb 2006 08:20:22 -0500
Received: by wproxy.gmail.com with SMTP id i2so107191wra
        for <linux-acpi@vger.kernel.org>; Wed, 15 Feb 2006 05:20:21 -0800 (PST)
In-Reply-To: <1140001153.8856.1.camel@localhost>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Just one more information i got from my 2.6.12-10 kernel's source. I'm
not a kernel hacker but I could find some points that it may be
calling that error messages.

What I got is that both errors on parser/psparse.c and
utilities/uteval.c call the acpi_ns_report_error with the message
"Method execution failed" that's why we see that particular order on
/var/log/messages.

As far as I can tell, it can only be one of those two errors:
acpi_ps_parse_loop or acpi_ns_evaluate_relative. Couldn't be
acpi_ns_evaluate_relative because it have a special treatment for
AE_NOT_FOUND and the error message is different, thus it must be on
acpi_ps_parse_loop.

Also, I noted that acpi_ps_parse_loop has no special treatment for
AE_NOT_FOUND and also does not return it by it's own, so it's probably
returned by some methods it calls.


Now, for the code snippets:

  - drivers/acpi/parser/psparse.c:1112 - 1138

    while (walk_state) {
        if (ACPI_SUCCESS (status)) {
            /*
             * The parse_loop executes AML until the method terminates
             * or calls another method.
             */
            status = acpi_ps_parse_loop (walk_state);
        }
(...)
        if (status == AE_CTRL_TRANSFER) {
(...)
       else if ((status != AE_OK) && (walk_state->method_desc)) {
            ACPI_REPORT_METHOD_ERROR ("Method execution failed",
                walk_state->method_node, NULL, status);


  - drivers/acpi/utilities/uteval.c:150 - 162

    status = acpi_ns_evaluate_relative (path, &info);
    if (ACPI_FAILURE (status)) {
        if (status == AE_NOT_FOUND) {
            ACPI_DEBUG_PRINT ((ACPI_DB_EXEC, "[%4.4s.%s] was not found\n",
                acpi_ut_get_node_name (prefix_node), path));
        }
        else {
            ACPI_REPORT_METHOD_ERROR ("Method execution failed",
                prefix_node, path, status);
        }

        return_ACPI_STATUS (status);
    }


  - drivers/acpi/namespace/nsutils.c:70

void
acpi_ns_report_error (...)
(...)
    acpi_os_printf ("%8s-%04d: *** Error: Looking up ",
        module_name, line_number);



cheers,
--rengolin
