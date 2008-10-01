From: Duarte Silva <duartejcsilva@gmail.com>
Subject: Re: Problems evaluating WMI method
Date: Wed, 1 Oct 2008 21:13:50 +0100
Message-ID: <200810012113.50723.duartejcsilva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:43699 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbYJAUQQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Oct 2008 16:16:16 -0400
Received: by fg-out-1718.google.com with SMTP id 19so508208fgg.17
        for <linux-acpi@vger.kernel.org>; Wed, 01 Oct 2008 13:16:14 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I found out the problem. Looking at a part on the WMAB code

Method (WMAB, 3, Serialized)
{
    Store (Arg0, MAR0)
    Store (Arg1, MAR1)
    Store (Arg2, MAR2)
    (...)

    If (LEqual (MAR0, 0x33))
    {
        If (LEqual (MAR1, One))
        {
            If (ECON)
            {
                Store (^^PCI0.LPCB.EC.DFAN, Local0)
            }
            (...)
            Return (Local0)
       }
       (...)

I know the posible values for DFAN, they are 12, 22 and 2. This are the states 
of the laptop fan. So when I do WMAB(0x33, 0x01, 0x00) it should return one 
of those values. In wmi.c we got this 

acpi_status wmi_evaluate_method(const char *guid_string, u8 instance,
u32 method_id, const struct acpi_buffer *in, struct acpi_buffer *out)
{
    (...)
    input.count = 2;
    input.pointer = params;
    params[0].type = ACPI_TYPE_INTEGER;
    params[0].integer.value = instance;
    params[1].type = ACPI_TYPE_INTEGER;
    params[1].integer.value = method_id;

    if (in) {
        input.count = 3;

        if (block->flags & ACPI_WMI_STRING) {
            params[2].type = ACPI_TYPE_STRING;
        } else {
            params[2].type = ACPI_TYPE_BUFFER;
        }
        params[2].buffer.length = in->length;
        params[2].buffer.pointer = in->pointer;
    }

    strncat(method, block->object_id, 2);

    status = acpi_evaluate_object(handle, method, &input, out);

So, when I try to evaluate the WMAB method, the parameters will be screwed up 
because we are not only passing the structure, we are also passing the 
instance and the method_id to WMAB. The following is a stack look like 
representation.

[CORRECT] [CURRENT]
arg0           instance -> gets to be the Arg0
arg1           method_id -> gets to be the Arg1
arg2           arg0 -> gets to be the Arg2
                  arg1
                  arg2

I got the correct answer when I do instance = 0x33 and method_id = 0x01. So, I 
looked at hp-wmi.c code and acer-wmi.c and they depend on this instance and  
method_id. But my laptop doesnt seem to depend. Is this instance and 
method_id a WMI standart or is it a HP and Acer laptop specific? My laptop is 
a LG.
