From: Rich Ibbotson <richibb-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org>
Subject: Re: ACPI/ECDT on gateway 200x notebook
Date: Tue, 06 Jan 2004 19:39:11 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FFB552F.8030508@rochester.rr.com>
References: <3FF773E5.5070102@rochester.rr.com> <Pine.LNX.4.44.0401032005180.7785-100000@data.upl.cs.wisc.edu> <20040106183426.GJ14031@poupinou.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010709020805000903080605"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040106183426.GJ14031-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Casey Harkins <charkins-TFaeeA7fOO6Gwcnyzrk3/w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------010709020805000903080605
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for the reply.  I've attached the disassembled dsdt from
"iasl -d  dsdt.dat".  I notice that the iasl output has "\_SB.PCI0" 
whereas the acpidmp output has "\_SB_.PCI0".  I'll try that with your 
fake_ecdt patch.

I do see an error and two warnings when I let iasl compile the dsdt:

Compiling "dsdt.dsl"
dsdt.dsl   163:     Method (_WAK, 1, NotSerialized)
Warning  2026 -                ^ Reserved method must return a value (_WAK)

dsdt.dsl  2620:                     Field (ECR, DWordAcc, Lock, Preserve)
Error    1048 -                              ^ Host Operation Region 
requires ByteAcc access

dsdt.dsl  2666:                     Method (_GLK, 1, NotSerialized)
Warning  2024 -                                ^ Reserved method has too 
many arguments ( _GLK requires 0)

thanks,
Rich

Ducrot Bruno wrote:
> On Sat, Jan 03, 2004 at 08:07:26PM -0600, Casey Harkins wrote:
> 
>>I think its now been determined that the problem is not from a missing
>>ECDT. Check out the bugzilla entry where work is being done to solve this
>>problem. I'm hoping to test the patch on one of our 400VTX's this week.
>>
>>http://bugzilla.kernel.org/show_bug.cgi?id=1744
> 
> 
> The patch initiazile EC(s) as the really first device(s) (but I am 
> perhaps wrong, since I read it really quickly though), which break
> acpi "spirit" imnsho.  The EC is a child of other devices and you
> have to be sure that those devices are initialized before EC (even
> though that is done by BIOS at POST already, due to legacy access
> in some laptops).
> 
> 
>>On Sat, 3 Jan 2004, Rich Ibbotson wrote:
>>
>>>Dear ACPI Gurus,
>>>
> 
> 
> [...]
> 
> 
>>>I do see an entry for "\_SB_.PCI0.LPCB.H_EC._REG" in the DSDT, though:
>>>
>>>000028c5:         Method _REG (\_SB_.PCI0.LPCB.H_EC._REG)
>>>000028cb:           ArgCount 2; NotSerialized
>>>000028cc:           If
>>>000028ce:             LAnd
>>>000028cf:               LEqual
>>>000028d0:                 Arg0
>>>000028d1:                 0x03
>>>000028d3:               LEqual
>>>000028d4:                 Arg1
>>>000028d5:                 0x01
>>>000028d7:             Store
>>>000028d8:               0x01
>>>000028da:               ECON (0000024e)
>>>000028de:             Store
>>>000028df:               \_SB_.PCI0.LPCB.H_EC.ACEX (00002844)
>>>000028f6:               \PWRS (00000160)
>>>
> 
> 
> Please do not use acpidmp, but iasl instead, or send a raw dsdt.
> 
> Look at http://acpi.sf.net/ for how to get iasl.
> 
> Cheers,
> 


--------------010709020805000903080605
Content-Type: application/x-bzip2;
 name="dsdt.dsl.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="dsdt.dsl.bz2"

QlpoOTFBWSZTWWQgbp4AQXh/gHxURERUd//wP///9L/v//pgLZ8e9ADT7YKQGt0pTQBHXnye
s3e5975zNgc5qcobO7HTq7D6b7NPd33l9zhry9XO1Ub60gK+vht5999dvvasvLd7PW+efN7O
19mtvuNe+77tr292Gd195Tvfet33X3ebuPgrvuzvt2T66qtYB0wg7O7p1FRAEkQmkwEaGmkN
U/TTRppT0JpHlDGkNA9QNAAJTQgmgmiZMmjUyptqo/VPUZqAyDEABkAAEgpI0mptU2IzRqJt
RpjUbUw1Bk0NNGgAAAJNJEQgaqntNJ6FPKe1PSQwAEwjAjIwQwIESU0GomTE0p5M1GQakM0a
ZTJppmUD0hphAAFRJEQ0BTMiZHkCaU/Km0J5T1ANDQAA9QbU7Z4PjFFSWWLJUixYXspKWWIN
ZpKkVKIsqyTUkSJ+aRBSUkVFiNo5S0stLPzrKpGpb5J7Y4J0DmHKqqEeYaMm8jZIaQGWlBwK
wbsrgqSCG01YgjdqXrbSQ2iPTpmAW/LliCv2+p1I9TbA2XRqRukrULQqRK0FbULUKIzLWCwW
CiwUIsFRJOokA3FIkUiyCjPb83j8Lt6SdBixZgdWEEAOkmsk0lmoRJUqIpBSFSRChFqGSZIw
mGCmWMSlKlWCBDrEgRZBjA2ooiHigUTs0RhFCenfMWbt85QsiooY1YRRPb4AfKSSD4XckpII
wXJ4hwBNEyTWo4ytGtoklArRsMLTJBYokQEjFBbIslrElkzJCjEmjVmNVFAxHAZEcRuSWSoR
HEYiRjSjEUJKKstalsRSAeLCRPAShRkCMEjFAgMHIIjIrdoxMBlVY7qRliWxVhZSi7VtpcxC
YyEUfJklnWbahJSkBAQKwMJEDBigiLBGSKRUBWW0iPVbJEtqKBQVtEsNTV1BCaQpFjA1FIID
EyQEgrI5YtrBgXKBhllSMUixGEWAqqpJctlYMUwKqliHNQUVIjFRkDYrIpFkFWBPPvmSCdNV
UQHEPJ833NfCBO0GCSMgKcAFKS0Tii5aK5FVisKUzKzFZCsqyMiFTEySLW0mIORUUsVTdYir
Ks4e/Q085s6bOq8rq86R0LKSpSpzJzHI2MMVVTJIU2TkwLbYqpNxU2VjDc0VgYVKmypGytGK
TTSYdevY5+Pv483OISE80QkWSIghTdCQRoVGhRSIgP3xVE9eAUI6j7vtoolkk/6TjDB/rSGC
qn5DWoNWiyLBD+zDAQxP/WpCbErYaCkMdYRBD0uhREgWQK7/IVVDg8AMiclJdRlElYwigPsU
4qLD2AYXGsojpBkNjAOXOgpP3wniIiGCAhg3ZHC2uyOFt6t0jckxAwxOCHdFUhzFIkeYCeZY
cTe5JgYUIUMHr/YkLXVBgBQow1mLzNC4TrzhDMNJCBC5Az0pJEz9RiOiMyIjGxotLiuIKdUU
WLBRRYsFFFiyVzWQzL4AJqEehYE2zSREES0HCyRkLVtb4wVgzZUpQPGXkAyTZDmaiyIDKSd4
UKHY1iSMnU6AFLIlgW74zJNAcw3ZmLS222HiwaGEyRvIcN0DqFBAqqltLPzmyn6TQB48qqqq
qqqq2HPUnB010RVisRw6Ybzmbp0TpInFum5bbbbbbbbbbazPI8ADeobI7C9sxFWKxFwdJbSn
Q7Ya8CTeThixQWUeCesOpsNbnLkMxVwHmW2W2XMQKpCHg9CKNy8x2UgZvQKDg0hSLhgLBZKk
lqVEqN1ZCrLJJaWlpbCVbIvpjXoSIg6EVBUPhSTJz+7E0klWBOjy0hpVUkN8RQ90VXljSie3
IpRSCxFMNtKIjQWQIq1aK40g7O7YPIiYAt+B0+z7vlD5cPQg3rzh1aP3cwLVnfx3bfcfV40G
wZmYQvgDiECAMg67MDGDh6hiGfd4rfnOJ+Ek/+OlMLT8f9McHyYynmv7OJvCqVaXdFxI/i0s
4aHEvL7JVgEx1uVUr35u+ROGOLGGPodGPxM5neGIVbR763hQ+CCrg5aRlbiXU0a3wDXUI7K8
PO2vVYqIvfc/mxH8XmxKM8ohmfP4QQGbubgYfKiC9dE2Zqn27nDZphPk+sqpbVfZ7JDndPjX
p29+34NWeBc45P+5o3PwyePHPynxxWlamDQ7sMwMyIJ/nh2pbEKAb9GnSfbza7dlTKihq8KB
7KiYLs1PDwYQ0oZoSoMOw9/jHx9PfTnlljHNnJzeGb3TBxB7JWszPaBZEPR79yzudTt8W/fV
VVVVVVV6m7o93gdVR7pCtqk6bwsNsyRpsyPSlcLWhxIDaHRTUHFpKFgBJE3h18DQ1pLjc9hk
NopBcPR/bNynjpvi1vGVrWta1rOZaZZVrllll8Z7Nyns4wstqwlVzsynkixu7nrHnA9mo0Au
b0XXnEbwZwhIQgEQGtLIeEXflE2u6aDNuc6Jy7TY7Eqp8R6XC8Z6kBQMVWJ6IjzvTkBgClFR
QdziVmCOxAyOwGCQySVbIDQTywzrFK8TEzxiEAzc3sV+siQZgfDyBJtbTV5YQQH1DrKlOnyI
GEOMSkSTCUA4Ok/UF11MsuQNqHFgCx4DPNImDVw73PVQquy9s7dCeQJIbDA4NkTCnBSYbJLp
UERKIX1nrJ8tX1YUdwNtEw8sSzVBFZRbdty1SQqZ6rHGRF1UkDZJZ0UDtRFW7SQuGT1Svx+n
0GbtYqaCSXKwoCCSRyTIJpMDvLmkTFHNEAniXpQyIpSlYMfoG/EEmRwV0lAkK2STQOSZFDbX
Otb27jTMz0DINwRAitKygkmYmTMNPqwq/HnjPy00WYydbk5GpL0irQ9jrdsdZ001vjCHvd4J
V2dstUaahrbtyDIrVJVao103h5B4DzGnyC1dNYttlKYDSGjtnABLgehgMyCTMjJM7nW5pOj0
MO5u625CzairTaZOHJQb7piiVFGvCq1qq1qq2PtJDPg+TpmZnme897e7tmnTILFiwP7kNMNt
YCI5QXE0mUJe7Tky76HtzeTS7NosJJJJJIaX10ZyjDabKOWLPLMVusw+Pm71Wo0cpeEuoyl2
lnHTwhEBTQ07/cuRz4meHenGpWjAnSYcDZa1drXd79PGu14za98nHhsghnGTNEuPtxK/lwa3
xLGbg3l05QaL0cR+vN3nCtZpfeKoWnZ+k17Ps27aezDz+eGdDwhChT2+zTdpv007e1rKadfK
mdT2Lb9tbacJQlXTfoiIz4ZfWtau7zMzNq1ridM3hQtt81hYrbN9rRbKdfOUqHd4V9nHVuv9
t0U2nGryuaFVdWyfCp5G+FFclI3mmjW0hGyKY2ifCuHAz2UadWlXX6BV5W5347Yx8PWQaFUA
yAvKcsuUtsek28XZgVjV0d7J9LFKN50s1rQNozxjU428gAGwGAK2hFwPcvyOXDS0v459YR36
7xkxhOm30fW/C8O3bt2mhEV9XenvPL8jPnTkS2e6hXV1CusLClVVFRUVEs+e+yFmwIRhFW8f
KSSSSRb29O/v7CQjKTKp8jm9H8tYSeTFd4+O6OzB9nO29i4eMW23LCrM9UDa1LAOf2qcq+2/
bVsqHKaN1JKsbvZCsOTK2oERbTluGTEO+UCNpflYiNwmnI9pIo1RKtyeXKwcjPbFw1HqiC4X
iBZ+bXiBNwBcBGsvs6ghsCmZnYocMsiA0UIgFClEoMhLLtiar0GrZHCWrEEdMdeRqpoXVk3E
DE8jbcV6/4eZnmncajCVcbYkpUcwZs/ppiFjGJJmZi3XpO+2m/a7aNhpHCgg4DzG1x343gl3
okvzM51yKAikpVJpgZhtw57dE4fbC6BZZFGMhCEgcBOag/lPl5a8eXluHLGxobEEAgg0gI4C
DUEFCpaMdKRZiYskxLB08VNKeErtRUCp3+LznRw9E6UZOu6WWEQNFGutzTRTs4VaTyAOw2IM
bK+yQgBDbnqHvYonfQV5BhzUh++5/zVfC9lC91KspyZN7jfvgE+FZfKqtVK3U8A5Dlwc0LEk
Fz7iSSSSR4p45l03jPCS81dbqV1wPTgwNn6H+5Tisr34CY9U3l102tjni1rWta1nLWta1LWm
tbcZwdvNoch0jByfNVVVLr6DRpVEITBRjZuvAv0b7TXQvokiZskkkJJI+mTN9mZXulf71kNo
4DmmZuYNDM9/U1IZrXwzaKIHSIwJFA8M7LPpq2kfFv7ptFZr3XY7/WCu0BxSDgAfU7AT9G0N
BSRjAZpSbSDWA0LIKkwJZ4emsxE70tbvyLx27fdKUuzh3PQPA5kSAVCh5nwZEhI5JJpuklbL
J91RNKS2Sz9GlGmntfnpzW4A/Wki6+/eAWbE2Du7iHbhjPXuzr6/jxqJCQkJdHovNNPM+WIi
dxojGevtXO/rB6ekwZxMOkmCGYb/0A0NDvw+9dTfLC2221GO/8z2STwG0ozM2BRQYUO7bPrz
+P8O0G0aGkdsJwuWFwiNKMVZFA9nH1ft/fqzFR+ifhB3xmQMwDbnCOP1w+Pd2xNN3vJm7Gcj
m3Yyo4M6ZAdRsjzlzQJDg7jrIAyMgL2fLsIaAsxNUzQvc4CSWkAf2gPm18xqVFyyKCi4A8ZE
gSBUvgk2EHXuHA5HuGxqSVsUIIEUeQpoVUDjzmJO74PigOPYBuRY00bMbmhvy6s3zn3Ruc5i
LsvdqSKmSPAYQW26oave58Y48tv0L42UgG/aUwAF2sBpGWWes0FXQz3brMN9heGRVolddXXX
vvLi1XVvbgBSajNTgFKLAnYp3HoEjimkg9HLwOSUmZaC4nZmsalawIkEgo5AnSnU4lCoTnG1
R+AiYH7pvbY0wc5RGYFR82cZzLgkhFGlXYGkxxM6tVhDFjTaQjn6nQJ54dwydtRkJFho1n1C
jaRT3REdW68Wxv1W21JJJJb8c6Tm/T93vcJBXvF76RqDNDg3AodRHALdgrBEfePHSiRdelJh
nbSwrbDHpzxDZBkRvJMgopg6BTm4DQnGkKBvljeRmkl2DHHtBS1waBhm9ka+2tIiCJYCUw8T
nw87bbc9Um8ZgLBSRIQl2mw5O0TQuru7u7g1GpRx3g8X0xxti+uJL+ul8YoWs7qAduFsNchL
IQ4Ndu2oEzKT1boTrTeQh1xtYTJIqqUUqznwyVtiavQ2MpaFpUq2VTemULVEpJCASSDCMijp
hSLCKvDhwwABtDvbFnY6TBkmmShpmmGAxgKRENtCVEJAE1kFb3vgLYxNL2SkuWDCWkK99eGo
aSQ6de2BNHFB6GTq1NMGJIsJrpKiobyI3imBCBsK0YOEV7baGA6awmaw1oKSKyGtawmgRGQQ
ZNjCEp8dkoiKdKAU8WFxhLPC0EEywnVgYatAXVALMALYLV522pNRbMxGDU0NEdjZyXhXQ8aQ
28tO/xSSltkl8oer7uYYvvFEvqYIbBpWSTdvN5osjcmExQpjFVBvCIMgP5IxhFRikIK6mjUt
Wxtlam2MTZKpa0SYaFb0wskhqt7S2WUqSikTY2NzUiNiWQEQREBVdsrCCooCkQgskDRosmCL
IpqhRYTeyhsNAWCGvy5jFgkIhBEiMRCMOTmhkYyYJKJKIVBYIqKLIKEBBCMBgiruwoMEgu6F
BirAYMWRgwRUggnJzQJgmZZSqZMEzHMgoG6SwjFgiERcaCpZjJDBimWUypipJaoqFILAEEWC
REVYQFYyTlLIIhDDBFOkvnkDYOd4nNW58WvGM2IMnxl0nKfPJ8DYJD4D3XB7B8meI8PuNCrY
CMJRzUhtPkKn2PgPBmWoSIdCwDl7g5oIYVBhnTMDrw19iGxR9SOzQCZkBjGUZ8nOPLlyx8/s
cm5QsmDYOPDkq1ecFgYqSXF0kdoE7IoKvQeUII5jnQcfTAyYfcggQeRZmqedLAW202mMKihK
SYA21pOQZyh8UBPFqogPrHk3JE7HcvzQPYVaVL52QsgxWdW8+7CnzQBbgpAag1CTXS1I3rpX
7NJeZJIyxeWrfWPnpNhNjLe+UDwcoZJKoGYWQURVjE6TxxSwGkN2s3bWnWBc98DhNIPf5ObA
PVcqeNI8nr8tXgySKU+jxYk7jx+iIwQJmIC2T/TZzXbffPV9/g9YnciHbquCYbo76e+0mlef
r87s75vbNXsPpMUqpSUsmlYtri0deql5+DRlkXcWkVhyrrrhaGxGBcT3atKQJMbo4t05dO4U
dwcCeg4NM2xPpr3g77t07RBsqx3cSsPS7SEwu05kK4KxohRJSLCwgMQKHf1tJ2QsZGQUaJ5Y
j7X8Mx8kHVym1gkaBNwDvEifavtb5qN3Gs+q4wO3smOSOZHu0A+JQsgsg9UkArqKoti4BdS3
bZ7eWWzxbdWvz586RLzMzzbzwM6Y48gzzJqm8zQ3cHIBwTcmB1VllvBRJDEwbTQnTKzOAUfe
BaDmsVlNju7u7u/HPCZp3A6DayGM4V5yJNipBSEAu3nE/CQoh41d6TEcgHfpV4ZJJajbkte7
G8OxZJ2Y6+z1ZuRaR9Vk108G1jKdJmOs1rTQzFpWjPGdac3rRz7nVe2xxrsrs62Mea3TBnqe
EUiWYgO09pDA2qD1LyqUhgPcaJe6U0klNkIhbe9t2EIQhEqlbZWHbou2xVIyF3i5kRo3VCK0
BDN36r4nNkFHajQ3GUsFm0xrfeXIGiiNbhr165JJJJ5uUySK2DHVhAxsLN4yIjiYVwEB7XU6
s0EsPw8uBE3WuSX12UcxKmBAqJozYJYhiGFADDEhxwpWMwKy1cc2NOmm1eY+X6vwPH9v3+U8
Y9tBSklZxbXiAdv0oPWd3nuCbBrzQG4E7AK/pPV41EQbBo9aNaEfkHUua5su+EqFIRiVhCqv
3rbLVW22WqttsmSZCfeAWRJpVVVVUhpWAqwKypa1QRILARYSE8m/4O39XKx6La8jNTthiYV4
Y4F4Gc+H5MwLZVqR1gwiMUA8Ll/DIwCgR97hH9QWtUshqdPlC5DukmFauVSgxBDQIly8BazM
IBvigjmMeltg+qqo/CFci/v8D/479fp3tVVVbkJC8foVPQDn8gHuhP+tAZzdRAw9u70g6Me/
2w9nWXONDd+wrWgCp0VvOCcpHFS9pb5i8aelmmZnOjAXPlmq19dAWQOzoLuzHw3elBzwheKz
UGQBzCvkikwyo3k9QQg7cg0EYF8XEObVT5XJppws1Yw+K/o50g/SanuVogOLArrWc3Ywtd3h
YMkOIhONhzvZat9JtAU8yJlpbm1yVB3XvVV0jnoOar082z+2YBlL1E9nyifIc6MHzlmrGkWj
BKOz4iG1Ytu4+GwW+BPbElT3VThIbj7/hFQUF48KFayVJwCcECuCwpnCiXuyLhI8LXGYkW+D
eGFfEdMI7g1mlxS9NBfXarLpA6kNRBuFqw9ksEwAbk2+EImti0WJUqtDAfQSF6sByA3nsC7c
h7BzCiwqKqK4uKD2Hw8Zx67XPr72p8NQ4imssvxgJ4CFfcoWVTnA93V0TMDzOsbVYEYxqSKc
JK7SUNRx+HxKcPVzdB7RSDtSoOJFbBqPP3QR9NjVwAoYtYdhUWB08KqY3HiHu8YRxDopQIA3
ri8AacuM3HSIx1+ZM5MMlxHIpJSBWVAU69eycaNru8CMYxlGXs9FDoojKMZln1EY7TaI955D
uXvAfOL8ontHM+cj5ECExkhCOIbDaB6HgnOeU5OHjV2fUNGmgWQz9QSyiAHGMZ/kMXJxWP2d
g0+0lzaTcIHQk6pbzh1nkLPOJ5eZ8+w7+nHTyt9sYylgAwJkuqonwnENZkSGNGMPz06w0rcd
vk1STwu93R1pOiIiunIfp0dhRqIjPl8szMzNpBvz7Yp9ZSZr+uTu7pJGTBXTmEANByG5DHHB
W+TcWMPB9YC+wCRIng8Ph66hMGyak+ULTUSm59o8J3B+EhZ/cnZ7fs9vwaS1lTKnjw5w4p4E
E9hgoep7LHqhy5DiOQFxDyHd8/n5R5buuyJo1jgQaiiqqqqVFLznOc56KRrzovh3YCF7fe4P
A9+PTXnfMiZqR7mtvnXkVI/Vq3MwA0jVVVVVftQYp2A7dgCgWgFFQCUASglBw5evj8olINP0
q5NOoTm9mNvZ2dU82zGW2sVe8/F8g9Flskemvm/8PAfpqS1Knd0TQjgjmHSDYaTvHpegVSrV
VVVJzmQ85PyhPp42VOhK6D8SmaWu3MWrJKtWmx38E3vv3OOAZRq7PvnQmzZOnCLwYTT0LtVS
TozVhE0IY4RLJwQykYYWwmn04KBNSkkeVnrjwQu4GRFk3r29OnTrX17LQGUYxnOefnNbpppp
ppc0hfsnanlhDzPsAOoWhnKEp7RlBIWTISBxMgHdUQ6HdN+dUgWs9MW2/lhCELbeQuLi2222
6NSbG022NsbWwYg4RzUJ052Pwkn1k0HGpSSWoVFklQksFpasikUssLH67ZFov74B39vX1BLN
nvwvQrGQWYt6mHgWAVgmxWk4yI8F5uNp2ZI3bKpSqqqpVUqlSrHah6u91Reac3o65GkpLIfN
nWWaT6edQ9IB6Xc/P8QQ8SU/HhO9hJFJAhgybBMZuVGaMFLZvJAuMWLE4EuDswpuzBTQo7We
C1dev2+x7EJhoeIE0KiisIxQ8TRlZCP+EJMOwkHkYZoR3AbPQGnJZ/ZLlut2N4/IQSiGCCIi
CJBTo96kZBowwQFIoPgywKgXV2GBSHuHiCc4p20ojjcdRmFJdsEKevagF1YBH0YHXFckpclF
kpbSBNrw16BUngH4sbtwOLWEuMpmeBEsw4hr+5DdbWdChrDwFlWC2/sJpe+LDZKwIQYaCcCa
OYbOD9+Rx8qJEfUi/rE9X1axmHWTvVfNq3ukuW0qJn2xWTEHkfIabJ67g9l7q4KVQyAQTIgH
Pys6p2JoEgkT2UpaUtKWlLSlpS0pbPiRRRRRRRRRRRRcEqkr0T2iYNJeKXJF4VDtTYMMojxY
DsjgPRBYCNPFCheinr1zaGKPi7Kthy8JFN4vcDgOAJ3xUy8yhyEXaIQefxcfGDwMTfybQFqx
bHMMEGRVe1O/6KYEk0Ts34J5YJtitwA7CDhwyZOcTIADr8T6wtiEzgAgt4B56t/GH0EyQJ+J
vx+SW222uW22226FyGg1AD8HnBHeR9GEgyEl3tnOlIoHOlSpUTZRB7uE7WJihi4beBmdFIjB
ipjCDbQQxbSnUAHaW5JdxofjPDB4kOQs8/lXTjQ4KbRMF3AN7KmYqjn3u2ORbID1mw1MI4K4
GHa+bJYEQpKSoPyMEIwHKB0XJFR06zccuIpIpIpJ7netSHtUNzTDj3XB3da2qtt7ZU1+jjH1
2HZJzK5bgaDWK6ovbcW+/2wM1gDoNxX4CSSSkkg2PjunftA23BOlSHpC3dIxIrIpVLSypaio
qUUlFkWxKKj7BgcRxhWJ7eO0jbE0nojUuzPcKloi90bGyzDKGBRsxx1YGUwSZi6H4BEM1J1w
LJRgYc0UWScmdYIdW7aNUswbtJg0qSjdNimYc7FGyGKVllSYRC5kRIB2B4un0+jz9cLSpIqq
qxVVRZTg+jT5lOSG+FoWVWKqqqqqqqvBr4d73mup7AQ+LnWShIsUuLaAFst8mCGYwQx7dh6A
mrd5a7u6lS2wB6NmOVzhsN+6ZjpqIkHYG6ERwQi9DxCybl+k5RmeYkqaipFwFhA2uOO448dX
MitxOelzDy+gM3o454dXTJC6F1c85R1Bp4In3ZLk7W6qqJVV1779KTt8JPGu8UEAYgwCKneg
dA+J6IlQu+M2HMi5WRfPC6Ef12R2lTqpDi9ltW2XbT2d8sTfgSjlDGEkQPTFF5geO2TAF/MD
PVYkWqliSUiLCfapiyPvhPSDzAGiA+lDBQ+5Aekf+II/eKiH0/7BJByQgD0/1zK/xALEXnLw
/zeJKQCSeYIkobDZ+4Ao3IZ7lT2ioh8ipmqF4gWCcJDbmD79tCagn7XOgfUc8fyaFh0cIbIb
PGE3O6dyMlKpYUlFJejJBiaMxGjFwkYslzImiilGipU0WLTCLSWG8sa0isMkNsMGlsiDZCJy
FqCczaFg8OcN+CBzcIkfNt+XfwkLEHQnaklEf6JYKWWKlkSyxYtC2EnmWSL5xkyGXEUsW0lB
PRApOIWQqGrEoNiMtKwGg1jLXK61hTBFPCYhckkjv/dJHCuzocoKxDkFkkahDZD805SHJRWw
CeIA7FDRMQFfUohWPY6AqGIBQoav+3zvf61aBNXMAbe1FWyWXoNgh4xT5hXiIadf8B0RkSbu
fioWt/rrBO8FQ4+f/ACceCpwVOgQekHZZFLgcQVN0Qbh4CT0JHaske4I+RUkhZ4+HnHT4jeJ
HpJvvEiyT1xBvSdyJJ74JwcmyDgRsnk+gPNB9eSQ/t13EkNwciSGeAk6fxiST1SQ2STtJ+h6
QbeXqkOI4ciPDnB3xXwhPU/liMEBZf36CkQWIEaxRBJBigQZzDJAhdfm5UgYKohcfKK4Iq8u
oApOjZhbMFQ4YogcVNpdTPYal6M88C6IBBCQU8kkjdyEhYsEIggoiLCDGNX3F6ZCkeSPjJBM
0NRIz2cMicVl9wSOYSqSCmwpqQqgEeghcxJCB9zpI9ZJDzoG0h+N+53Ii/b6MJteB4/FETyQ
kOHikfdIdgI4ITrDXrO/93Hzn0glCu9Sa+XUgjuS6hm6QUpIBGJLJHZD5YRxQnp4IiZUEnKK
EIdAoPtEO0A1iG9U0EVuCodKBNQiBEEsCcxWuKkFPAekG+ChmbFH0ckQNiZl1T4UU6uy5jiK
uRPyWswOlslWSHiYWTnvSOpI0jUnCSxvoLa9NmQFtEdFQuBgIjkq2QNTSKwtKIzn5SaQvS4k
kNcUk4YR1SOLqQ+xCQ+ENacyIOP5wicIdkh6fiOfePlI9vHrQnhIg4utwd8kdJHUHvoF0RIq
n2igoPBQ7jJBLoaAEOoVlMOanijtXapmICfl7wT6gA+tAfcCL9goD9gqPtRX3AvwAHvCAt1b
olxW6Kl0UbohdUuBoOrRP7xLg3FLiAXBfx+73/baTs98LH4lFhZbcDsAgm4E3CcA4Jv3rv3q
lzmQNQwGCf/F3JFOFCQZCBungA==
--------------010709020805000903080605--



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
