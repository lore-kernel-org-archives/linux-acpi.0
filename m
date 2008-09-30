From: Duarte Silva <duartejcsilva@gmail.com>
Subject: Problems evaluating WMI method
Date: Tue, 30 Sep 2008 23:56:09 +0100
Message-ID: <200809302356.09618.duartejcsilva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:34734 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386AbYI3W6f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Sep 2008 18:58:35 -0400
Received: by ey-out-2122.google.com with SMTP id 6so108512eyi.37
        for <linux-acpi@vger.kernel.org>; Tue, 30 Sep 2008 15:58:33 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

After parsing the _WDG buffer from a PNP0C14 device I got this (the format is 
<guid> - <object-id> - <parsed-guid-type> - <guid-type>)

C3A72B38-D3EF-42D3-8CBB-D5A57049F66D - AB - method - 2
E4FB94F9-7F2B-4173-AD1A-CD1D95086248 - event - 8
023B133E-49D1-4E10-B313-698220140DC2 - event - 8
37BE1AC0-C3F2-4B1F-BFBE-8FDEAF2814D6 - event - 8
911BAD44-7DF8-4FBB-9319-BABA1C4B293B - event - 8
4E5C4404-3CED-4A5E-8C7A-1BA875D00A43 - BA - method - 2
2B4F501A-BD3C-4394-8DCF-00A7D2BC8210 - BB - method - 2
05901221-D566-11D1-B2F0-00A0C9062910 - AC - unknown - 0

That first GUID map to WMAB (I guess).  So why when I do this (simplified 
version)

struct acpi_buffer out = { ACPI_ALLOCATE_BUFFER, NULL };
struct acpi_buffer in;
structwmab_args args = {
	.mar0 = 0x00,
	.mar1 = 0x01,
	.mar2 = 0x00,
};

in.length = (acpi_size)sizeof(struct wmab_args);
in.pointer = &args;

wmi_evaluate_method("C3A72B38-D3EF-42D3-8CBB-D5A57049F66D", 1, 1, &in, &out);

printk( KERN_INFO "QUERY %i\n", (u32)out.length);

kfree(out.pointer);

I get a output with a lenght of 24 and when I convert it to a acpi_object I 
get type integer. Result in dmesg

QUERY 24

When the code in WMAB is

Method (WMAB, 3, Serialized)
{
    Store (Arg0, MAR0)
    Store (Arg1, MAR1)
    Store (Arg2, MAR2)
    If (LAnd (LGreaterEqual (MAR0, Zero), LLessEqual (MAR0, 0x2F)))
    {
        If (LEqual (MAR0, Zero))
        {
            If (LEqual (MAR1, One))
            {
                Return (0x0300)
            }
            Return (0x80000002)
       }
       (...)

With the parameters I provided it should be returning something like 0x300. 
What Iam doing wrong?
